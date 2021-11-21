function cSpecCon = getconstructor(this, stype)
%GETCONSTRUCTOR   Get the constructor.

%   Author(s): V. Pellissier
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2006/10/18 03:24:40 $

if nargin < 2
    stype = get(this, 'SpecificationType');
end

switch lower(stype)
    case 'n,f0',
        %#function fspecs.octavewordncenterfreq
        cSpecCon = 'fspecs.octavewordncenterfreq';
    otherwise
        error(generatemsgid('internalError'), 'InternalError: Invalid Specification Type.');
end


% [EOF]

