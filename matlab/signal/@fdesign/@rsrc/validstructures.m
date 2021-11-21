function vs = validstructures(this, dm)
%VALIDSTRUCTURES   Return the valid structure for the design method.

%   Author(s): J. Schickler
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2005/06/16 08:25:33 $

if this.InterpolationFactor > this.DecimationFactor
    vs_str = {'firsrc', 'firfracinterp'};
else
    vs_str = {'firsrc', 'firfracdecim'};
end

% If we are not given a design method, return a structure.
if nargin < 2
    d = designmethods(this);
    for indx = 1:length(d)
        vs.(d{indx}) = vs_str;
    end
else
    vs = vs_str;
end

% [EOF]
