function varargout = validate_coeffs(this, coeffs)
%VALIDATE_COEFFS   Validate the coeffs

%   Author(s): R. Losada
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2007/12/14 15:07:17 $

msg = [];

if nargout
    varargout = {msg};
else
    if ~isempty(msg), error(generatemsgid('SigErr'),msg); end
end

% [EOF]
