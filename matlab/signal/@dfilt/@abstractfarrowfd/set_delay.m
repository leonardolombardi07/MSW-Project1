function delay = set_delay(this, delay)
%SET_DELAY   PreSet function for the 'delay' property.

%   Author(s): V. Pellissier
%   Copyright 2005-2006 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2007/05/23 19:12:22 $

if delay<0,
    error(generatemsgid('InvalidDelay'), 'The Delay must be positive.');
end

if delay>1,
    error(generatemsgid('InvalidDelay'), 'The Delay must be lower than 1.');
end

if ~isreal(delay),
    error(generatemsgid('InvalidDelay'), 'The Delay must be real.');
end


delay = super_set_delay(this, delay);

% [EOF]
