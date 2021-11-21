function s = dispstr(this, varargin)
%DISPSTR Display string of coefficients.
%   DISPSTR(Hd) returns a string that can be used to display the coefficients
%   of discrete-time filter Hd.
  
  
%   Author(s): R. Losada
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2005/12/22 18:56:26 $

c = lcldispstr(this,this.AllpassCoefficients(:), varargin{:});

s = char({xlate('Allpass Coefficients:')
          c
          });

% [EOF]
