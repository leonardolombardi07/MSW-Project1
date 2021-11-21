function s = dispstr(Hd, varargin)
%DISPSTR Display string of coefficients.
%   DISPSTR(Hd) returns a string that can be used to display the coefficients
%   of discrete-time filter Hd.
%
%   See also DFILT.   
  
%   Author: Thomas A. Bryan
%   Copyright 1988-2005 The MathWorks, Inc.
%   $Revision: 1.5.4.4 $  $Date: 2006/06/27 23:33:46 $

[ap1, ap2, beta] = dispstr(Hd.filterquantizer, Hd.Allpass1q(:), ...
    Hd.Allpass2q(:), Hd.privBeta, varargin{:});

s = char({xlate('Allpass1.Lattice:')
          ap1
          ''
          xlate('Allpass2.Lattice:')
          ap2
          ''
          xlate('Beta:')
          beta
         });

% [EOF]