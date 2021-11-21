function cSpecCon = getconstructor(this, stype)
%GETCONSTRUCTOR   Return the constructor for the specification type.

%   Copyright 2008 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2008/10/31 07:00:42 $

if nargin < 2
    stype = get(this, 'SpecificationType');
end

switch lower(stype)
    case 'n,q',
        %#function fspecs.combq
        cSpecCon = 'fspecs.combq'; 
    case 'n,bw',
        %#function fspecs.combbw
        cSpecCon = 'fspecs.combbw'; 
    case 'l,bw,gbw,nsh',
        %#function fspecs.comblbwgbwnsh
        cSpecCon = 'fspecs.comblbwgbwnsh';         
    otherwise
        error(generatemsgid('internalError'), 'InternalError: Invalid Specification Type.');
end

% [EOF]
