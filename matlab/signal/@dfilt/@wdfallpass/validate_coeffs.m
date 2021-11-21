function varargout = validate_coeffs(this, coeffs)
%VALIDATE_COEFFS   Validate the coeffs

%   Author(s): R. Losada
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.3 $  $Date: 2007/12/14 15:10:01 $

msg = [];

if length(coeffs) > 4 || length(coeffs) == 3,
    msg = 'Coefficients must be a vector of length 1, 2, or 4.';
elseif length(coeffs) == 4 && (coeffs(1) ~= 0 || coeffs(3) ~= 0),
    msg = 'When coefficients are a four element vector, the first and third coefficient must be equal to zero.';
end
if isempty(msg),
    c = wdfcoefficients(this,coeffs);
    if any(abs(c.Section1) > 1) || any(isnan(c.Section1)),
        msg = 'The allpass coefficients specified result in wave coefficients greater than one in magnitude.\nThis is not supported. Make sure the allpass coefficients correspond to a stable filter.';
    end
end

if nargout
    varargout = {msg};
else
    if ~isempty(msg), error(generatemsgid('SigErr'),msg); end
end

% [EOF]
