function s = dispstr(Hd, varargin)
%DISPSTR Display string of coefficients.
%   DISPSTR(Hd) returns a string that can be used to display the coefficients
%   of discrete-time filter Hd.
%
%   See also DFILT.   
  
%   Author: Thomas A. Bryan
%   Copyright 1988-2005 The MathWorks, Inc.
%   $Revision: 1.3.4.4 $  $Date: 2006/06/27 23:34:26 $

[num, den] = dispstr(Hd.filterquantizer, Hd.privNum(:), Hd.privDen(:), varargin{:});

s = char({xlate('Numerator:')
          num
          xlate('Denominator:')
          den
         });

% [EOF]
