function Hd = dispatch(this)
%DISPATCH   Returns the LWDFILT.

%   Author(s): R. Losada
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2005/11/18 14:23:47 $

if ~isempty(this.AllpassCoefficients),
    c = struct2cell(this.AllpassCoefficients);
else
    c = [];
end

if isempty(c),
    H = dfilt.allpass;
else
    for k = 1:length(c),
        H(k) = dfilt.allpass(c{k});
    end
end

Hd = cascade(H);

% [EOF]
