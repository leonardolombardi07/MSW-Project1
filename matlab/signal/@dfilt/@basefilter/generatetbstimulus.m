function inputdata = generatetbstimulus(filterobj, varargin)
%GENERATETBSTIMULUS Generates and returns HDL Test Bench Stimulus
%   GENERATETBSTIMULUS(Hd) automatically generates the filter
%   input stimulus based on the settings for the current filter.
%   The stimulus consists of any or all of impulse, step, ramp,
%   chirp, noise, or user-defined stimulus.  Note that the results
%   are quantized using the input quantizer settings of Hd. If the
%   arithmetic property of the filter Hd is set to 'double', then
%   double-precision stimulus is return. If the arithmetic property
%   is set to 'fixed', then the stimulus is return as a fixed-point
%   object.
%
%   GENERATETBSTIMULUS(Hd, PARAMETER1, VALUE1, PARAMETER2, VALUE2, ...) 
%   generates the test bench with parameter/value pairs. Valid 
%   properties and values for GENERATETBSTIMULUS are listed in 
%   the HDL Filter Designer documentation section "Property Reference."
%
%   Y = GENERATETBSTIMULUS(Hd,...) returns the stimulus to MATLAB
%   variable Y. 
%
%   GENERATETBSTIMULUS(Hd,...) with no output argument plots the 
%   stimulus in the current figure window.
%
%   EXAMPLE:
%   h = firceqrip(30,0.4,[0.05 0.03]);
%   Hb = dfilt.dffir(h);
%   y = generatetbstimulus(Hb, 'TestBenchStimulus',{'ramp','chirp'});
%   generatetbstimulus(Hb, 'TestBenchStimulus','noise');
%
%   See also GENERATEHDL, GENERATETB, ISHDLABLE.

%   Copyright 2003-2008 The MathWorks, Inc.
%   $Revision: 1.1.6.8 $  $Date: 2008/12/01 07:41:34 $ 

  [cando, errstr] = ishdlable(filterobj);
  if ~cando
    error(generatemsgid('unsupportedarch'), errstr);
  end

  % Parse TestBenchStimulus and TestBenchUserStimulus parameters
  hprop = PersistentHDLPropSet; % Get persistent HDLPropSet
  if isempty(hprop),
      hprop = hdlcoderprops.HDLProps;
      PersistentHDLPropSet(hprop); % Make hprop persistent
      hdlsetparameter('tbrefsignals', false); % Default specific to FDHC
  end
  set(hprop.CLI,'TestbenchUserStimulus', []); % resets to "forget"
  set(hprop.CLI,'TestbenchStimulus', '');
  set(hprop.CLI,varargin{:});
  updateINI(hprop);
  hINI = hprop.INI;
  hdl_parameters  = hINI.getPropSet('TestBench').getPropSet('Common');
  stimparam = hdl_parameters.tb_stimulus;  
  if isempty(stimparam) && isempty(hdl_parameters.tb_user_stimulus),
        stimparam = defaulttbstimulus(filterobj);
  end

  slope = 2;
  bias = 1;
  chirpslope = 1;
  chirpbias  = 0;

  if (isfir(filterobj) && ~isa(filterobj, 'mfilt.cascade') ) ...
          || issos(filterobj)
    ilen = impzlength(filterobj);
  else
    ilen = 256;                         % default value
  end

  zlen = ilen;                          % transition band 

  range = [0:1023];

  stimdata = [];

  if any(strcmpi('impulse', stimparam))
    impulse = zeros(1,ilen);
    impulse(1) = 1.0;
    stimdata = [stimdata, impulse];
  end

  if any(strcmpi('step',stimparam))
    if ~isempty(stimdata)
      stimdata = [stimdata, zeros(1,zlen)];
    end
    step = ones(1,ilen);
    step(1) = 0;
    stimdata = [stimdata, step];
  end

  if any(strcmpi('ramp',stimparam))
    if ~isempty(stimdata)
      stimdata = [stimdata, zeros(1,zlen)];
    end
    ramp = slope.*(range./range(end)) - bias;
    stimdata = [stimdata, ramp];
  end

  if any(strcmpi('chirp',stimparam))
    if ~isempty(stimdata)
      stimdata = [stimdata, zeros(1,zlen)];
    end
    chin = chirpslope.*chirp(range,0,range(end),0.49) + chirpbias;
    stimdata = [stimdata, chin];
  end


  if any(strcmpi('noise',stimparam))
    if ~isempty(stimdata)
      stimdata = [stimdata, zeros(1,zlen)];
    end
    rnd = slope.*rand(1,range(end)+1) - bias;
    stimdata = [stimdata, rnd];
  end

  if ~isempty(stimdata)
    stimdata = [stimdata, zeros(1,zlen)];
    % Correct the zero padding for decimators such that the overall
    % length is a a multiple of the decimation factor.
    if isa(filterobj,'mfilt.abstractmultirate') || ...
          isa(filterobj,'mfilt.cascade')
      rcf = getratechangefactors(filterobj);
      if all(rcf(:,1) == 1)             % is a decimator
        stimlen = length(stimdata);
        stimmod = mod(stimlen,prod(rcf(:,2)));
        if stimmod ~= 0
          stimdata = [stimdata, zeros(1,(prod(rcf(:,2)) - stimmod))];
        end
      end
    end    
  end

  if ~isempty(hdl_parameters.tb_user_stimulus)
    if ~isempty(stimdata)
      stimdata = [stimdata, zeros(1,zlen)];
    end
    userdata = hdl_parameters.tb_user_stimulus;
    if size(userdata, 1) > 1
        userdata = userdata.';
    end
    stimdata = [stimdata, userdata];
  end
    
  if isempty(stimdata)
    error(generatemsgid('unknownstimulus'),...
          'No test bench stimulus was generated');
  end
  
  if isa(filterobj,'dfilt.cascade')
    tmpfilt = filterobj.Stage(1);
  else
    tmpfilt = filterobj;
  end

  switch tmpfilt.arithmetic
   case 'double'
    stimdata = double(stimdata);                % do nothing
   case 'fixed'
     stimdata  = fi(stimdata, true,...
                    tmpfilt.InputWordLength, tmpfilt.InputFracLength,...
                    'fimath', fimath('RoundMode','round','OverflowMode','saturate'));
  end

  if nargout==0
    stimdata = double(stimdata);
    % Build Title string
    nstims = length(stimparam);

    if ~isempty(hdl_parameters.tb_user_stimulus)
      if nstims == 1
        stimname = 'stimulus';
        stims = sprintf('%s ',stimparam{:});
      else
        stimname = 'stimuli';
        stims = sprintf('%s, ', stimparam{:});
      end
      if isempty(stims)
        stims = 'user defined';
        stimname = 'stimulus';        
      else
        stims = [stims 'and user defined'];
        stimname = 'stimuli';
      end
    else % no user defined stimulus
      if nstims == 1
        stimname = 'stimulus';
        stims = sprintf('%s ',stimparam{:});
      elseif nstims == 2
        stimname = 'stimuli';
        stims = sprintf('%s and %s ', stimparam{:});      
      else
        stimname = 'stimuli';
        stims = sprintf('%s, ', stimparam{:});
      end
      if stims(end-1:end) == ', '
        stims = stims(1:end-2);           % remove trailing comma & space
      else
        stims = stims(1:end-1);           % remove trailing space        
      end
      lastcomma = find(stims==',');
      if ~isempty(lastcomma)
        stims = [stims(1:lastcomma(end)), ' and', stims(lastcomma(end)+1:end)];
      end
    end

    %hdl = stem(stimdata);
    hdl = plot(stimdata);
    ylim(ylim.*1.1);                    % add some white space around the top and bottom
    title(sprintf('Stimulus data for filter %s\nwith %s %s.',...
                  inputname(1), stims, stimname),...
          'Interpreter','none');
    
  else % return the data
    inputdata = stimdata;
  end

% [EOF]

