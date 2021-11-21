function realizeflag = isrealizable(Hd)
%ISREALIZABLE True if the structure can be realized by simulink

%   Author(s): Honglei Chen
%   Copyright 1988-2008 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2009/01/20 15:35:00 $

realizeflag = true;
% Limited support for AllpassCoefficients
% 
c = coeffs(Hd);                                                       
if isempty(find(length(c.AllpassCoefficients)==[0 1 2 4], 1)),                    
    warning(generatemsgid('InvalidCoeffs'), ...                                   
        'The length of the AllpassCoefficients vector must be 0, 1, 2 or 4.'); 
    realizeflag = false;
end                    
% [EOF]
