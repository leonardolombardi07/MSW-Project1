function this = arbmagnphasemeas(hfilter, varargin)
%ARBMAGNPHASEMEAS   Construct an ARBMAGNPHASEMEAS object.

%   Author(s): V. Pellissier
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2007/12/14 15:11:10 $

error(nargchk(1,inf,nargin,'struct'));

this = fdesign.arbmagnphasemeas;

% Parse the inputs.
minfo = parseconstructorinputs(this, hfilter, varargin{:});

if this.NormalizedFrequency, Fs = 2;
else,                        Fs = this.Fs; end
    
% Measure the arbitrary magnitude filter.
this.Frequencies = minfo.Frequencies;
this.FreqResponse = freqz(hfilter,minfo.Frequencies,Fs);

% [EOF]
