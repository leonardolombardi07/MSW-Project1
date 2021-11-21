function [out coeffnames variables] = mapcoeffstoports(this,varargin)
%MAPCOEFFSTOPORTS 

%   Copyright 2009 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2009/07/14 04:00:18 $

out = parse_mapcoeffstoports(this,varargin{:});

stages = length(this.privallpasscoeffs); 
coeffnames = cell(1,stages);
for k = 1:stages
    coeffnames{k} = sprintf('C%d',k);
end

idx = find(strcmpi(varargin,'CoeffNames'));
if ~isempty(idx),
    userdefinednames = varargin{idx+1};
    % if user-defined coefficient names are empty, return the default names.
    if ~isempty(userdefinednames)
        coeffnames = userdefinednames;
    end
end

if length(coeffnames)~=length(this.privallpasscoeffs)
    error(generatemsgid('InvalidParameter'),...
        'There must be %d coefficient names.',length(this.privallpasscoeffs));
end

coeffs = this.privallpasscoeffs;

% If the coefficient variable of the first stage is empty, then there is
% no coefficient to be exported. Therefore, remove the coefficient name.
if isempty(coeffs{1})
    variables = {};
    coeffnames = {};
else
    variables = coeffs;
end

% [EOF]
