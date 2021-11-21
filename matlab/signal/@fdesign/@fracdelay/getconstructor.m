function cSpecCon = getconstructor(this, stype)
%GETCONSTRUCTOR   Get the constructor.

%   Author(s): V. Pellissier
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2006/05/09 23:44:20 $

if nargin < 2
    stype = get(this, 'SpecificationType');
end

switch lower(stype)
    case 'n',
        %#function fspecs.fdword
        cSpecCon = 'fspecs.fdword';
    otherwise
        error(generatemsgid('internalError'), 'InternalError: Invalid Specification Type.');
end


% [EOF]

