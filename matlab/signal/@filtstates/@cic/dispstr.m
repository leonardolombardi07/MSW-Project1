function s = dispstr(this, offset)
%DISPSTR   Return the display string.

%   Author(s): J. Schickler
%   Copyright 1988-2004 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2004/07/28 04:37:29 $

if nargin < 2
    offset = 6;
end

[nsections, nchannels] = size(this.Integrator);

% nchannels = length(this);

% Show the first channels integrator and comb lengths.
IntStr  = sprintf('[%dx%d States]', nsections, nchannels);

[nsections, nchannels] = size(this.Comb);

CombStr = sprintf('[%dx%d States]', nsections, nchannels);

s = sprintf('Integrator: %s\n%sComb: %s', ...
    IntStr, blanks(offset), CombStr);

% [EOF]
