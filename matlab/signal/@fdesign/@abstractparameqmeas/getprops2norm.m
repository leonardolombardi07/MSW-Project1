function props2norm = getprops2norm(this)
%GETPROPS2NORM   Get the props2norm.

%   Author(s): R. Losada
%   Copyright 2006 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2006/10/18 03:24:21 $

props2norm = get(this, { ...
    'F0' ...
    'BW' ...
    'BWpass' ...
    'BWstop' ...
    'Flow' ...
    'Fhigh'});

% [EOF]
