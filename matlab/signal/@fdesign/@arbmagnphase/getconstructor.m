function cSpecCon = getconstructor(this, stype)
%GETCONSTRUCTOR   Get the constructor.

%   Author(s): V. Pellissier
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2005/11/18 14:25:03 $

if nargin < 2
    stype = get(this, 'SpecificationType');
end

switch lower(stype)
    case 'n,f,h',
        %#function fspecs.sbarbmagnphase
        cSpecCon = 'fspecs.sbarbmagnphase';
    case 'nb,na,f,h',
        %#function fspecs.sbarbmagnphaseiir
        cSpecCon = 'fspecs.sbarbmagnphaseiir';
    case 'n,b,f,h'
        %#function fspecs.multibandmagnphase
        cSpecCon = 'fspecs.multibandmagnphase';
    otherwise
        error(generatemsgid('internalError'), 'InternalError: Invalid Specification Type.');
end

% [EOF]
