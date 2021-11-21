function defaultmethod = getdefaultmethod(this)
%GETDEFAULTMETHOD   Get the defaultmethod.

%   Author(s): V. Pellissier
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2006/05/09 23:44:21 $

switch this.Specification,
    case 'N',
        defaultmethod = 'lagrange';
    otherwise,
        error(generatemsgid('InternalError'),'No default method for this specification set.');
end


% [EOF]
