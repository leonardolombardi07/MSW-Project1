function defaultmethod = getdefaultmethod(this)
%GETDEFAULTMETHOD   Get the defaultmethod.

%   Author(s): J. Schickler
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2005/08/20 13:26:09 $

switch this.Specification,
    case 'N,F,H',
        defaultmethod = 'freqsamp';
    case 'Nb,Na,F,H', 
        defaultmethod = 'iirls';
    case 'N,B,F,H', 
        defaultmethod = 'firls';
    otherwise,
        error(generatemsgid('InternalError'),'No default method for this specification set.');
end

% [EOF]
