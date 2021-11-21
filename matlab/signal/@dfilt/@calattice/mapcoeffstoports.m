function [out coeffnames variables] = mapcoeffstoports(this,varargin)
%MAPCOEFFSTOPORTS 

%   Copyright 2009 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2009/04/21 04:32:18 $

out = parse_mapcoeffstoports(this,varargin{:});

coeffnames = {'K1','K2','B'};
idx = find(strcmpi(varargin,'CoeffNames'));
if ~isempty(idx),
    userdefinednames = varargin{idx+1}; 
    % if user-defined coefficient names are empty, return the default names.
    if ~isempty(userdefinednames)
        coeffnames = userdefinednames;
    end
end

if length(coeffnames)~=3,
    error(generatemsgid('InvalidValue'), ...
        'The CoeffNames value must be a cell array containing three strings.');
end

variables = coefficients(this);


% [EOF]
