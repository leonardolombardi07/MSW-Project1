function Hd = calattice(k1,k2,beta)
%CALATTICE Coupled-allpass lattice.
%   Hd = DFILT.CALATTICE(K1,K2,BETA) constructs a discrete-time
%   coupled-allpass lattice filter object with K1 as lattice coefficients in
%   the first allpass, K2 as lattice coefficients in the second allpass, and
%   scalar BETA.  
%
%   This structure is only available with the Filter Design Toolbox.
%
%   Example:
%     [b,a]=butter(5,.5);
%     [k1,k2,beta]=tf2cl(b,a);
%     Hd = dfilt.calattice(k1,k2,beta)
%
%   See also DFILT/STRUCTURES   
  
%   Author: Thomas A. Bryan
%   Copyright 1988-2005 The MathWorks, Inc.
%   $Revision: 1.7.4.3 $  $Date: 2005/12/22 18:57:05 $

Hd = dfilt.calattice;

Hd.privAllpass1 = dfilt.latticeallpass;
Hd.privAllpass2 = dfilt.latticeallpass;

Hd.FilterStructure = 'Coupled-Allpass Lattice';

if nargin>=1
  Hd.Allpass1 = k1;
end

if nargin>=2
  Hd.Allpass2 = k2;
end

if nargin>=3
  Hd.Beta = beta;
end
