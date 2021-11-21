function b = genmcode(h, d)
%GENMCODE Generate MATLAB code

%   Author(s): J. Schickler
%   Copyright 1988-2004 The MathWorks, Inc.
%   $Revision: 1.1.8.4 $  $Date: 2010/01/25 22:50:20 $

[params, values, descs, iargs] = cremez_genmcode(d);
[a_params, a_values, a_descs]  = abstract_genmcode(h, d);
[fs, fsstr]                    = getfsstr(d);

b = sigcodegen.mcodebuffer;

b.addcr(b.formatparams({'N', a_params{:}, params{:}}, ...
    {getmcode(d, 'Order'), a_values{:}, values{:}}, ...
    {'', a_descs{:}, descs{:}}));
b.cr;
b.addcr(designdesc(d));
b.addcr('b  = cfirpm(N, %s, ''lowpass'', %s%s);', ...
    sprintf('[-%s Fstop1 Fpass1 Fpass2 Fstop2 %s]%s', fsstr, fsstr, fs), ...
    '[Wstop1 Wpass Wstop2]', iargs);
b.add('Hd = dfilt.dffir(b);');

% [EOF]
