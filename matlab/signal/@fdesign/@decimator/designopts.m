function d = designopts(this, varargin)
%DESIGNOPTS   

%   Author(s): R. Losada
%   Copyright 2005-2006 The MathWorks, Inc.
%   $Revision: 1.1.6.3 $  $Date: 2006/06/27 23:35:45 $

d = designopts(this.CurrentFDesign, varargin{:});

if isfield(d,'FilterStructure'),
    % Replace structure with multirate structure
    switch d.FilterStructure,
        case {'firinterp','dffir'},
            d.FilterStructure = 'firdecim';
        case 'cascadeallpass',
            d.FilterStructure = 'iirdecim';
    end
end




% [EOF]
