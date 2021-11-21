function d = designopts(this, varargin)
%DESIGNOPTS   

%   Author(s): R. Losada
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2005/12/22 19:00:57 $

d = designopts(this.CurrentFDesign, varargin{:});

if isfield(d,'FilterStructure'),
    % Replace structure with multirate structure
    switch d.FilterStructure,
        case 'dffir',
            d.FilterStructure = 'firinterp';
        case 'cascadeallpass',
            d.FilterStructure = 'iirinterp';
    end
end



% [EOF]
