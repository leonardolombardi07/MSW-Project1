function vs = validstructures(this, dm)
%VALIDSTRUCTURES   

%   Author(s): J. Schickler
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2005/06/16 08:23:24 $

vs_str = {'cicdecim'};

if nargin < 2
    vs.design = vs_str;
else
    vs = vs_str;
end

% [EOF]
