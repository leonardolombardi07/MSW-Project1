function this = arbmagmeas(hfilter, varargin)
%ARBMAGMEAS   Construct an ARBMAGMEAS object.

%   Author(s): V. Pellissier
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.3 $  $Date: 2007/12/14 15:11:08 $

error(nargchk(1,inf,nargin,'struct'));

this = fdesign.arbmagmeas;

% Parse the inputs.
minfo = parseconstructorinputs(this, hfilter, varargin{:});

if this.NormalizedFrequency, Fs = 2;
else,                        Fs = this.Fs; end
    
% Measure the arbitrary magnitude filter.
hfdesign = getfdesign(hfilter);
F = minfo.Frequencies;
this.Frequencies = F;
try
    A = zerophase(hfilter,F,Fs);
catch
    A = abs(freqz(hfilter,F,Fs));
end
this.Amplitudes = A(:).';

% [EOF]
