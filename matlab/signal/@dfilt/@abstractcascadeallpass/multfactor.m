function [f offset] = multfactor(this)
%MULTFACTOR   

%   Author(s): R. Losada
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2005/11/18 14:23:19 $


f = ones(1,length(this.refallpasscoeffs));
offset = zeros(size(f));

% [EOF]
