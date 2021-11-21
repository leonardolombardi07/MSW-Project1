function varargout=limitcycle(Hd,Ntrials,InputLengthFactor,StopCriterion)
%LIMITCYLE  Detect zero-input limit cycles in IIR quantized filters.
%   LIMITCYCLE(Hd) runs 20 Monte Carlo trials with random initial states
%   and zero input vector of twice the length of the impulse response. This
%   function stops if a zero-input limit cycle is detected in the quantized
%   filter Hd. A limit cycle type is returned which is one of 'granular' to
%   indicate that a granular overflow occurred; 'overflow' to indicate that
%   an overflow limit cycle occurred; or 'none' to indicate that no limit
%   cycles were detected during the Monte Carlo trials.
%
%   LIMITCYCLE(Hd, NTRIALS, INPUTLENGTHFACTOR, STOPCRITERION) allows
%   you to set
%
%     NTRIALS, the number of Monte Carlo trials (default is 20).
%
%     INPUTLENGTHFACTOR, the length of the zero vector as a multiple of the
%     length of the impulse response of the filter (default is 2).
%
%     STOPCRITERION, the stop criterion, a string containing one of
%     'either' (the default), 'granular' or 'overflow'.  If STOPCRITERION
%     is 'either', then the Monte Carlo trials will stop if either a
%     granular or overflow limit cycle is detected; 'granular', stop only
%     if a granular limit cycle was detected; 'overflow', stop only if an
%     overflow limit cycle was detected.
%
%   If any of the input values are empty ([]), then the default
%   values are used.
%
%   REPORT = LIMITCYCLE(Hd, ...) also returns a REPORT object with fields:
%
%     LIMITCYCLETYPE, one of 'granular' to indicate that a granular
%     limit cycle occurred; 'overflow' to indicate that an overflow limit
%     cycle occurred; or 'none' to indicate that no limit cycles were
%     detected during the Monte Carlo trials.
%
%     ZI the initial conditions that caused the limit cycle.
%
%     OUTPUT the output of the filter in the limit cycle (steady state).
%
%     TRIAL the number of the Monte Carlo trial that was stopped on.
%
%   If no limit cycles are detected, then the parameters of the last Monte
%   Carlo trial are returned.
%
%   Example:
%     s = [1 0 0 1 0.9606 0.9849];
%     Hd = dfilt.df2sos(s);
%     Hd.Arithmetic = 'fixed';
%     greport = limitcycle(Hd,20,2,'granular')
%     oreport = limitcycle(Hd,20,2,'overflow')
%     figure,
%     subplot(211),plot(greport.Output(1:20)), title('Granular Limit Cycle');
%     subplot(212),plot(oreport.Output(1:20)), title('Overflow Limit Cycle');

%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.5 $  $Date: 2010/05/20 03:10:06 $

error(nargchk(1,4,nargin,'struct'));
error(nargoutchk(0,1,nargout,'struct'));

if ~isfdtbxinstalled,
    error(generatemsgid('LicenseError'), 'A Filter Design Toolbox license is required to run the LIMITCYCLE method.');
end

if ~isfixptinstalled,
    error(generatemsgid('LicenseError'), 'A Fixed-Point Toolbox license is required to run the LIMITCYCLE method.');
end

if ~strcmpi(Hd.Arithmetic, 'fixed'),
    error(generatemsgid('ArithmeticError'), 'The ''Arithmetic'' property of the filter must be ''fixed'' to run the LIMITCYCLE method.'); 
end

if ~exist('Ntrials','var') || isempty(Ntrials)
    Ntrials=20;
end
if ~isnumeric(Ntrials) || ~isscalar(Ntrials) || fix(Ntrials)~=Ntrials
    error(generatemsgid('InvalidInput'),'Ntrials must be a scalar integer');
end
if ~exist('InputLengthFactor','var') || isempty(InputLengthFactor)
    InputLengthFactor=2;
end
if ~isnumeric(InputLengthFactor) || ~isscalar(InputLengthFactor) || fix(InputLengthFactor)~=InputLengthFactor
    error(generatemsgid('InvalidInput'),'InputLengthFactor must be a scalar integer');
end
if InputLengthFactor<2,
    error(generatemsgid('InvalidInput'),'InputLengthFactor must be greater than 1.');
end
if ~exist('StopCriterion','var') || isempty(StopCriterion)
    StopCriterion = 'either';
end
if isempty(strmatch(StopCriterion,{'either','granular','overflow'}))
    error(generatemsgid('InvalidInput'),'Invalid StopCriterion')
end

if ~isstable(Hd),
    warning(generatemsgid('UnstableFilter'),'Unstable filter.');
end
    
% The zero input vector
x = zeros(InputLengthFactor*impzlength(Hd),1);

% Initialize output variables
LimitCycleType = 'none';
ziOut = [];
periodOut = [];
trialOut = Ntrials;
yOut = [];

% Reset filter
reset(Hd);

% Cache fipref logging mode
f=fipref;
oldmode = f.LoggingMode;
f.LoggingMode = 'On';

for trial=1:Ntrials
    % For each Monte Carlo trial, generate random states and call the
    % THISLIMITCYCLE to filtering the zero input vector X. Examine
    % the output of the filter.
    [y,zi,Overflows] = thislimitcycle(Hd,x);
    
    [p msg] = period(double(y),Hd);

    if p~=0,
        if Overflows>0
            LimitCycleType = 'overflow';
        else
            LimitCycleType = 'granular';
        end

        % Store for output
        ziOut = zi;
        yOut = y;
        periodOut = p;
        trialOut = trial;
        
        % The Monte Carlo trials are halted if a limit cycle is found that matches
        % the StopCriterion ('either', 'granular', 'overflow').
        if strcmpi(StopCriterion,'either') || strcmpi(StopCriterion,LimitCycleType),
            break
        end
    end
end

if ~isempty(msg),
    warning(generatemsgid('NotEnoughData'), msg);
end

% Restore fipref logging mode
f.LoggingMode = oldmode;

% If no limit cycle was found, return the results of the last Monte Carlo
% trial
if isempty(ziOut)
    ziOut = zi;
    yOut = y;
    periodOut = p;
end

if (strcmpi(StopCriterion,'either') && strcmpi(LimitCycleType,'none')) || ...
      (strcmpi(StopCriterion,'granular') && ~strcmpi(LimitCycleType,'granular')) || ...
      (strcmpi(StopCriterion,'overflow') && ~strcmpi(LimitCycleType,'overflow'))
    warnstr = StopCriterion;
    if strcmpi(warnstr, 'either'),
        warning(generatemsgid('LimitCycleType'),...
            'No limit cycle of type %s or %s was detected. Returning parameters of the last Monte Carlo trial.',...
            'overflow','granular');
    else
        warning(generatemsgid('LimitCycleType'),...
            'No limit cycle of type %s was detected. Returning parameters of the last Monte Carlo trial.',warnstr);
    end
end

% Deal the outputs to the varargout cell array.
if nargout>0
    varargout{1} = quantum.limitcycle(LimitCycleType,ziOut,yOut,periodOut,trialOut);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [p msg] = period(y,Hd)
%PERIOD  Period of the limitcycle

p = 0; msg = '';
N = length(y);
msg1 = 'Cannot find limitcycle periodicity. Try increasing INPUTLENGTHFACTOR.';

if any(double(Hd.States))~=0 % If states are all zeros, filter converged
    levels = unique(y);
    if all(levels==0),
        % Output of filter converged
        return
    elseif length(levels)==N,
        p = Inf;
        msg = msg1;
        return
    end
    % First estimate of the slowest periodicity = greatest distance between
    % two points on the same level
    maxlevel = 0;
    for i = 1:length(levels),
        idx = diff(find(y==levels(i)));
        if ~isempty(idx),
            [p j] = max([p,max(idx)]);
            if j==2,
                maxlevel = idx;
            end
        end
    end
    if p>N/2,
        p = Inf;
        msg = msg1;
        return
    end
    % Differentiate contiguous windows of length p to find full period
    while any(y(N-2*p+1:N-p)-y(N-p+1:N)~=0),
        % Increase p if result was not zero
        q = find(maxlevel==p);
        if length(maxlevel)<q(1)+1,
            p = Inf;
            msg = msg1;
            return
        end
        % New estimate for p
        p = sum(maxlevel(q(1):q(1)+1));
        maxlevel(q(1)) = maxlevel(q(1)) + maxlevel(q(1)+1); %#ok<AGROW>
        if p>N/2,
            p = Inf;
            msg = msg1;
            return
        end
    end
end

