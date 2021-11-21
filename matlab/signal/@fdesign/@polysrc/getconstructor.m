function cSpecCon = getconstructor(this, stype)
%GETCONSTRUCTOR   Get the constructor.

%   Copyright 2007 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2007/11/17 22:44:17 $

if nargin < 2
    stype = get(this, 'SpecificationType');
end

switch lower(stype)
    case 'np',
        %#function fspecs.fdsrcword
        cSpecCon = 'fspecs.fdsrcword';
    otherwise
        error(generatemsgid('internalError'), 'InternalError: Invalid Specification Type.');
end


% [EOF]

