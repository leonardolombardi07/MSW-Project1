function defaultmethod = getdefaultmethod(this)
%GETDEFAULTMETHOD   Get the defaultmethod.

%   Copyright 2009 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2009/10/16 06:41:23 $

switch lower(this.Specification)
    case {'wt'}
        defaultmethod = 'freqsamp';
    case {'wt,class'}
        defaultmethod = 'ansis142';
    otherwise,
        error(generatemsgid('InternalError'),'No default method for this specification set.');
end


% [EOF]
