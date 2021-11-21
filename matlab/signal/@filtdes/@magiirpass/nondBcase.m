function nondBcase(h,d)
%nondBcase Handle the linear case.
%
% This should be a private method.

%   Author(s): R. Losada
%   Copyright 1988-2002 The MathWorks, Inc.
%   $Revision: 1.3 $  $Date: 2002/04/15 00:47:14 $

convertmag(h,d,...
    {'Apass'},...
    {'Epass'},...
    {'pass'},...
    @tosquared);