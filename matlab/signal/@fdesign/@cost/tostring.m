function str = tostring(this)
%TOSTRING

%   Copyright 2005-2009 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2009/11/13 05:03:34 $

costfn = fieldnames(this);

for nc = 1:length(costfn),
    value{nc} = num2str(getfield(this,costfn{nc}));
end

param = cell(length(costfn), 1);

for k = 1:length(costfn),
    switch lower(costfn{k}),
        case 'nmult',
            param{k} = 'Number of Multipliers';
        case 'nadd',
            param{k} = 'Number of Adders';
        case 'nstates',
            param{k} = 'Number of States';
        case 'multperinputsample'
            param{k} = 'Multiplications per Input Sample';
        case 'addperinputsample'
            param{k} = 'Additions per Input Sample';
        otherwise
            param{k} = costfn{k};
    end
end
str = [strvcat(param) repmat(' : ', length(param), 1) strvcat(value)];

% [EOF]
