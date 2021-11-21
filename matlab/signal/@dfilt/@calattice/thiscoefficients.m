function c = thiscoefficients(Hd)
%THISCOEFFICIENTS Filter coefficients.
%   C = THISCOEFFICIENTS(Hd) returns a cell array of coefficients of
%   discrete-time filter Hd.
% 
%   THISCOEFFICIENTS(Hd) with no output argument displays the coefficients.
%
%   See also DFILT.   
  
%   Author: Thomas A. Bryan
%   Copyright 1988-2002 The MathWorks, Inc.
%   $Revision: 1.6 $  $Date: 2002/09/18 12:38:15 $
  
c = {Hd.Allpass1, Hd.Allpass2, Hd.beta};
