function b = genmcode(h, d)
%GENMCODE Generate MATLAB code

%   Author(s): J. Schickler
%   Copyright 1988-2003 The MathWorks, Inc.
%   $Revision: 1.1.6.3 $  $Date: 2010/01/25 22:52:14 $

[params, values, descs, str] = fir1_genmcode(d);

b = sigcodegen.mcodebuffer;

b.addcr(b.formatparams({'N', 'Fc', params{:}}, ...
    {getmcode(d, 'order'), getmcode(d, 'Fc'), values{:}}, ...
    {'', '', descs{:}}));
b.cr;
b.addcr(str);
b.cr;
b.addcr(designdesc(d));
b.addcr('b  = fir1(N, Fc%s, ''low'', win, flag);', getfsstr(d));
b.add('Hd = dfilt.dffir(b);');

% [EOF]
