function coeffs = set_coeffs(this, coeffs)
%SET_COEFFS   PreSet function for the 'coeffs' property.

%   Author(s): R. Losada
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2005/12/22 18:56:30 $

% Always convert to row vector
coeffs = coeffs(:).';

% Check that coeffs are valid
msg = validate_coeffs(this,coeffs);
if ~isempty(msg),
    error(generatemsgid('invalidCoeffs'),msg);
end

% Make sure to clear metadata
clearmetadata(this);

% Set the reference coefficients
this.refallpasscoeffs = coeffs;

oldncoeffs = length(this.AllpassCoefficients);

% Quantize the coefficients
quantizecoeffs(this);

% If number of coeffs changes, flush states
if  oldncoeffs~= length(coeffs),
    reset(this);
end

% Hold an empty to not duplicate storage
coeffs = [];

% [EOF]
