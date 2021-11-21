function defaultmethod = getdefaultmethod(this)
%GETDEFAULTMETHOD   Get the defaultmethod.

%   Author(s): V. Pellissier
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2006/10/18 03:24:41 $

switch this.Specification,
    case 'N,F0',
        defaultmethod = 'butter';
    otherwise,
        error(generatemsgid('InternalError'),'No default method for this specification set.');
end


% [EOF]
