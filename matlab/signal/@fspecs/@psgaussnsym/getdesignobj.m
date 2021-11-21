function designobj = getdesignobj(this, str)
%GETDESIGNOBJ Get the design object
%   OUT = GETDESIGNOBJ(ARGS) <long description>

%   Copyright 2008 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2008/10/31 07:03:00 $

designobj.window = 'fmethod.gausswin';

if nargin > 1
    designobj = designobj.(str);
end

% [EOF]
