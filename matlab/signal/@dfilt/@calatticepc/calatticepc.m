function Hd = calatticepc(k1,k2,beta)
%CALATTICEPC Power-complementary coupled-allpass lattice.
%   Hd = DFILT.CALATTICEPC(K1,K2,BETA) constructs a discrete-time
%   coupled-allpass lattice with power-complementary output object with K1 as
%   lattice coefficients in the first allpass, K2 as lattice coefficients in the
%   second allpas, and scalar BETA.
%
%   This structure is only available with the Filter Design Toolbox.
%
%   Example:
%     [b,a]=butter(5,.5);
%     [k1,k2,beta]=tf2cl(b,a);   
%     Hd = dfilt.calatticepc(k1,k2,beta)
%
%   See also DFILT/STRUCTURES   
  
%   Author: Thomas A. Bryan
%   Copyright 1988-2005 The MathWorks, Inc.
%   $Revision: 1.6.4.3 $  $Date: 2005/12/22 18:57:08 $

Hd = dfilt.calatticepc;

Hd.privAllpass1 = dfilt.latticeallpass;
Hd.privAllpass2 = dfilt.latticeallpass;

Hd.FilterStructure = 'Coupled-Allpass Lattice, Power Complementary Output';

if nargin>=1
  Hd.Allpass1 = k1;
end

if nargin>=2
  Hd.Allpass2 = k2;
end

if nargin>=3
  Hd.Beta = beta;
end
