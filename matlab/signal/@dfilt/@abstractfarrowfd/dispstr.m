function s = dispstr(Hd, varargin)
%DISPSTR Display string of coefficients.
%   DISPSTR(Hd) returns a string that can be used to display the coefficients
%   of discrete-time filter Hd.
%

%   Copyright 2007 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2007/08/03 21:39:41 $

s = char({xlate('Coefficients:')
    dispstr(Hd.filterquantizer, Hd.privcoeffs(:), varargin{:})});

% [EOF]
