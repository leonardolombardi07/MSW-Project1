function R = mapresponse(this, SR)
%MAPRESPONSE   

%   Author(s): J. Schickler
%   Copyright 2005-2009 The MathWorks, Inc.
%   $Revision: 1.1.6.3 $  $Date: 2009/02/13 15:13:40 $

switch lower(SR)
    case 'ciccomp'
        R = 'CIC Compensator';
    case 'arbmag'
        R = 'Arbitrary Magnitude';
    case 'arbmagnphase'
        R = 'Arbitrary Magnitude and Phase';
    case 'isinclp'
        R = 'Inverse-sinc Lowpass';
    case 'rcosine'
        R = 'Raised Cosine';
    case 'sqrtrcosine'
        R = 'Square Root Raised Cosine';
    otherwise
        R = [upper(SR(1)) SR(2:end)];
end

% [EOF]
