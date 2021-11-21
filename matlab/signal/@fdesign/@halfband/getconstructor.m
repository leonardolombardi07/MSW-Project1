function cSpecCon = getconstructor(this)
%GETCONSTRUCTOR   Return the constructor for the specification type.

%   Author(s): J. Schickler
%   Copyright 1999-2005 The MathWorks, Inc.
%   $Revision: 1.1.6.5 $  $Date: 2007/10/23 18:47:51 $

switch lower(this.SpecificationType)
    case 'tw,ast',
        if strcmpi(this.privType,'Lowpass'),
            %#function fspecs.hbmin
            cSpecCon = 'fspecs.hbmin';
        else
            %#function fspecs.hphbmin
            cSpecCon = 'fspecs.hphbmin';
        end
    case 'n,tw',
        if strcmpi(this.privType,'Lowpass'),
            %#function fspecs.hbordntw
            cSpecCon = 'fspecs.hbordntw';
        else
            %#function fspecs.hphbordntw
            cSpecCon = 'fspecs.hphbordntw';
        end
    case 'n,ast',
        if strcmpi(this.privType,'Lowpass'),
            %#function fspecs.hbordastop
            cSpecCon = 'fspecs.hbordastop';
        else
            %#function fspecs.hphbordastop
            cSpecCon = 'fspecs.hphbordastop';
        end
    case 'n',
        if strcmpi(this.privType,'Lowpass'),
            %#function fspecs.hbord
            cSpecCon = 'fspecs.hbord';
        else
            %#function fspecs.hphbord
            cSpecCon = 'fspecs.hphbord';
        end
    otherwise
        error(generatemsgid('internalError'), 'InternalError: Invalid Specification Type.');
end

% [EOF]
