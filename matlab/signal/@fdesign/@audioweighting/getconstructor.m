function cSpecCon = getconstructor(this, stype)
%GETCONSTRUCTOR   Get the constructor.

%   Copyright 2009 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2009/10/16 06:41:22 $

if nargin < 2
    stype = get(this, 'SpecificationType');
end

switch lower(stype)
    case 'wt',
        %#function fspecs.audioweightingwt
        cSpecCon = 'fspecs.audioweightingwt';
    case 'wt,class',
        %#function fspecs.audioweightingwtclass
        cSpecCon = 'fspecs.audioweightingwtclass';        
    otherwise
        error(generatemsgid('internalError'), 'InternalError: Invalid Specification Type.');
end


% [EOF]

