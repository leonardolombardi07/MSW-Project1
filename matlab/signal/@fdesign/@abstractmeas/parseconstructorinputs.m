function specs = parseconstructorinputs(this, hfilter, hfdesign, varargin)
%PARSECONSTRUCTORINPUTS   Parse the constructor inputs.

%   Author(s): J. Schickler
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2005/06/16 08:20:58 $

% If the specification is not passed, use the stored specification.
if nargin < 3
    hfdesign = getfdesign(hfilter);
    if isempty(hfdesign)
        error(generatemsgid('missingFDesign'), ...
            'Cannot measure filters that were not created with FDESIGN.');
    end
end

specs = measureinfo(hfdesign);

% Sync up the sampling frequencies.
if ~hfdesign.NormalizedFrequency
    this.normalizefreq(false, get(hfdesign, 'fs'));
end

for indx = 1:2:length(varargin)
    specs.(varargin{indx}) = varargin{indx+1};
end

set(this, 'Specification', hfdesign);

% [EOF]
