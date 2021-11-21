function designobj = getdesignobj(this, str)
%GETDESIGNOBJ   Get the design object.

%   Author(s): J. Schickler
%   Copyright 1988-2005 The MathWorks, Inc.
%   $Revision: 1.1.6.4 $  $Date: 2007/10/23 18:48:50 $

%#function fmethod.cheby1hp
designobj.cheby1 = 'fmethod.cheby1hp';

if nargin > 1
    designobj = designobj.(str);
end

% [EOF]
