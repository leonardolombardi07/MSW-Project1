function varargout = validatercf(this, ifactor, dfactor)
%VALIDATERCF   Validate the rcf

%   Author(s): J. Schickler
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.8.2 $  $Date: 2007/12/14 15:11:40 $

if nargin < 3
    dfactor = get(this, 'DecimationFactor');
    if nargin < 2
        ifactor = get(this, 'InterpolationFactor');
    end
end

g = gcd(ifactor,dfactor);

if g > 1
    errmsg = sprintf(['L and M are not relatively prime.\nChange ', ...
        'InterpolationFactor to %d and DecimationFactor to %d.'], ...
        ifactor/g, dfactor/g);
    errid = generatemsgid('filterdesign:srconvert:primefactors');
else
    errmsg = [];
    errid = [];
end

if nargout
    varargout = {errmsg,errid};
else
    if ~isempty(errmsg), error(errid, errmsg); end
end

% [EOF]
