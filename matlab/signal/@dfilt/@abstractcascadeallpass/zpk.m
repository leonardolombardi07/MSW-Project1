function [z,p,k] = zpk(this)
%ZPK  Discrete-time filter zero-pole-gain conversion.
%   [Z,P,K] = ZPK(Hd) returns the zeros, poles, and gain corresponding to the
%   discrete-time filter Hd in vectors Z, P, and scalar K respectively.
  
%   Author(s): R. Losada
%   Copyright 2006 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2007/12/14 15:06:48 $

if ~isequal(size(this),[1,1]),
    error(generatemsgid('InvalidDimensions'),'Input must be a DFILT object of length 1.');
end         

hd = dispatch(this);
[z,p,k] = zpk(hd);

% [EOF]
