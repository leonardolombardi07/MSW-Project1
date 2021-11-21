function delay = set_delay(this, delay)
%SET_DELAY   PreSet function for the 'delay' property.

%   Author(s): V. Pellissier
%   Copyright 2005-2006 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2006/06/27 23:35:57 $

Fs = this.Fs;
if delay<0,
    error(generatemsgid('InvalidFracDelay'), ...
        'The fractional delay must be positive.');
end

if isprop(this.CurrentSpecs, 'privFracDelay')
    set(this.CurrentSpecs, 'privFracDelay', delay);
end

% [EOF]
