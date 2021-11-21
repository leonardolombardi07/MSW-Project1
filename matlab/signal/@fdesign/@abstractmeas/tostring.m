function str = tostring(this)
%TOSTRING

%   Author(s): J. Schickler
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.9 $  $Date: 2009/02/13 15:13:38 $

% Get all of the field names
f = fieldnames(this);

% Remove 'NormalizedFrequency and Fs because these are special cased above.
f(1:2) = [];

param = cell(length(f)+1, 1);
value = param;

param{1} = 'Sampling Frequency';
if this.NormalizedFrequency
    value{1} = 'N/A (normalized frequency)';
    fpost    = '';
    m        = 1;
else
    
    [fs m prefix] = engunits(this.Fs);
    
    fpost    = sprintf(' %sHz', prefix);
    value{1} = [num2str(fs) fpost];
end

for indx = 1:length(f)

    num = str2num(f{indx}(end));
    if isempty(num),
        d = '';
    else
        switch num
            case 1
                d = 'First ';
            case 2
                d = 'Second ';
            case 3
                d = 'Third ';
            case 4
                d = 'Fourth ';
        end
    end

    switch lower(f{indx})
        case {'transitionwidth', 'transitionwidth1', 'transitionwidth2'};
            d    = [d 'Transition Width'];
            post = fpost;
        case {'lowtransitionwidth'};
            d    = [d 'Low Transition Width'];
            post = fpost;  
        case {'hightransitionwidth'};
            d    = [d 'High Transition Width'];
            post = fpost;                        
        case {'apass', 'apass1', 'apass2'}
            d = [d 'Passband Ripple'];
        case {'astop', 'astop1', 'astop2'}
            d = [d 'Stopband Atten.'];
        case {'fpass', 'fpass1', 'fpass2'}
            d = [d 'Passband Edge'];
        case {'fstop', 'fstop1', 'fstop2'}
            d = [d 'Stopband Edge'];
        case {'f3db', 'f6db', 'f3db1', 'f6db1', 'f3db2', 'f6db2'}
            d = [d f{indx}(2) '-dB Point'];
        case {'nomgrpdelay'}
            d = 'Nominal Group Delay';
        case {'fracdelayerror'}
            d = 'Fractional Delay Error ';
        case {'f0'},
            d = 'Center Frequency';
        case {'bw'},
            d = 'Bandwidth';
        case {'g0'},
            d = 'Center Frequency Gain';
        case {'gref'},
            d = 'Reference Gain';
        case {'gbw'},
            d = 'Bandwidth Gain';
        case {'gpass'},
            d = 'Passband Gain';
        case {'gstop'},
            d = 'Stopband Gain';
        case {'bwpass'},
            d = 'Passband Bandwidth';
        case {'bwstop'},
            d = 'Stopband Bandwidth';
        case {'notchfrequencies'},
            d = 'Notch Frequencies';
         case {'peakfrequencies'},
            d = 'Peak Frequencies';
        case {'gnotch'},
            d = 'Notch Gains';
         case {'gpeak'},
            d = 'Peak Gains';
         case {'qa'},
            d = 'Quality Factor (audio)';            
        otherwise
            d = f{indx};
    end
    if isempty(this.(f{indx}))
        if strcmpi(f{indx},'qa')
            value{indx+1} = 'Not measurable for N>2';            
        else
            value{indx+1} = 'Unknown';
        end
    else
        if strcmpi(f{indx}, 'magnitudes') || strncmpi(f{indx}, 'g', 1) || (strncmpi(f{indx}, 'a', 1) && ~strcmpi(f{indx}, 'amplitudes'))
            post = ' dB';
            value{indx+1} = num2str(this.(f{indx}));
        elseif any(strfind(lower(f{indx}), 'delay'))
            delay = this.(f{indx});
            post    = sprintf(' samples');
            value{indx+1} = num2str(delay);
         
            if exist('fs'),
                [t m prefix] = engunits(delay,'time');
                post = sprintf(' %s', prefix);
            end
            value{indx+1} = num2str(delay*m);
        elseif any(strfind(lower(f{indx}), 'amplitudes')) || any(strfind(lower(f{indx}), 'freqresponse')) || strcmpi(f{indx},'q') || strcmpi(f{indx},'qa')
            value{indx+1} = num2str(this.(f{indx}));
            post    = '';
        else
            if this.NormalizedFrequency
                value{indx+1} = num2str(this.(f{indx}));
                post    = '';
            else
                [val mval valprefix] = engunits(this.(f{indx}));
                post    = sprintf(' %sHz', valprefix);
                value{indx+1} = num2str(val);
            end
        end

        value{indx+1} = sprintf('%s%s', value{indx+1}, post);
    end
    param{indx+1} = d;
end

str = [strvcat(param) repmat(' : ', length(param), 1) strvcat(value)];

% [EOF]
