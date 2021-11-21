function loadreferencecoefficients(this, s)
%LOADREFERENCECOEFFICIENTS   Load the reference coefficients.

%   Author(s): J. Schickler
%   Copyright 1988-2004 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2004/12/26 22:09:19 $

if s.version.number < 2
    set(this, 'A', s.A, ...
        'B', s.B, ...
        'C', s.C, ...
        'D', s.D);
else
    set(this, 'A', s.refA, ...
        'B', s.refB, ...
        'C', s.refC, ...
        'D', s.refD);
end

% [EOF]
