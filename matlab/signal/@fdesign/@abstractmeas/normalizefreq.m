function normalizefreq(this, newNormFreq, Fs)
%NORMALIZEFREQ   Normalize frequency specifications.

%   Author(s): R. Losada
%   Copyright 2003-2005 The MathWorks, Inc.
%   $Revision: 1.1.6.3 $  $Date: 2005/08/04 18:03:27 $

% Check for error condition first
if (nargin > 2) && newNormFreq,
    error(generatemsgid('FsnotAllowed'), ...
        'Specifying Fs is not allowed while requesting to normalize the frequency specifications.');
end

% Normalize by default.
if nargin < 2,
    newNormFreq = true;
end

% Check for early return condition next
if newNormFreq && this.NormalizedFrequency,
    return;
end

oldFs = this.Fs;
% Assign Fs if specified
if (nargin > 2) && ~newNormFreq,
    this.Fs = Fs;
end
    
values = getprops2norm(this);

oldNormFreq = get(this, 'NormalizedFrequency');
set(this, 'NormalizedFrequency', newNormFreq);

if newNormFreq,
    for indx = 1:length(values)
        values{indx} = 2*values{indx}/oldFs;
    end
else
    if ~oldNormFreq,
        % If normalized frequency was already false set Fs so that specs
        % are recomputed correctly
        cf = Fs/oldFs; % Correction factor
    else
        cf = Fs*0.5;
    end
    
    for indx = 1:length(values)
        values{indx} = cf*values{indx};
    end
end

setprops2norm(this, values);

% [EOF]
