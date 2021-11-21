function c = set_coefficients(this, c)
%SET_COEFFICIENTS   PreSet function for the 'coefficients' property.

%   Author(s): V. Pellissier
%   Copyright 2005-2006 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2007/05/23 19:12:56 $

if size(c,2)<2,
    error(generatemsgid('InvalidCoefficients'), ...
        'The ''Coefficients'' property must store a matrix with at least two columns.');
end

% Polynomes stored in rows
this.ncoeffs = size(c,1);
reset(this);

this.refcoeffs = c;

% Quantize the coefficients
quantizecoeffs(this);

c = [];

% [EOF]
