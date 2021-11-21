function setspecs(this,combtype,varargin)
%SETSPECS Set the specs

%   Copyright 2008 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2008/10/31 07:00:49 $

if nargin < 2
    return;
end

%set combtype in fdesign
if isequal('notch', lower(combtype))
    set(this, 'CombType', 'Notch');
elseif isequal('peak', lower(combtype))
    set(this, 'CombType', 'Peak');
else
    error(generatemsgid('InvalidCombType'), ...
        [' D = FDESIGN.COMB(COMBTYPE,SPECSTRING,VALUE1,VALUE2,...).' ...
         ' Missing or invalid comb type. Valid types are ''Notch'', and '...
         '''Peak''.']);
end

%Send the combtype as another argument in varargin so that it is set in
%fspecs
varargin{end+1} = combtype;
this_setspecs(this, varargin{:});

% [EOF]
