function this = isinclpmeas(hfilter, hfdesign, varargin)
%ISINCLPMEAS   Construct an ISINCLPMEAS object.

%   Author(s): J. Schickler
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.3 $  $Date: 2008/01/29 15:38:23 $

error(nargchk(1,inf,nargin,'struct'));

this = fdesign.isinclpmeas;

% Parse the inputs.
minfo = parseconstructorinputs(this, hfilter, varargin{:});
    
if this.NormalizedFrequency, Fs = 2;
else,                        Fs = this.Fs; end

idealfcn = {@defineideal, minfo.FrequencyFactor, minfo.Power, ...
    [minfo.Fpass/(Fs/2) minfo.Fcutoff/(Fs/2) minfo.Fstop/(Fs/2)]};

% Measure the lowpass filter remarkable frequencies.
this.Fpass = findfpass(this, reffilter(hfilter), minfo.Fpass, minfo.Apass, 'down', ...
    [0 Fs/2], idealfcn);
this.F3dB  = findfrequency(this, hfilter, 1/sqrt(2), 'down', 'first');
this.F6dB  = findfrequency(this, hfilter, 1/2, 'down', 'first');
this.Fstop = findfstop(this, reffilter(hfilter), minfo.Fstop, minfo.Astop, 'down');

% Use the measured Fpass and Fstop when they are not specified to have a
% true measure of Apass and Astop. See G425069.
if isempty(minfo.Fpass), minfo.Fpass = this.Fpass; end 
if isempty(minfo.Fstop), minfo.Fstop = this.Fstop; end

% Measure ripples and attenuation.
this.Apass = measureripple(this, hfilter, 0, minfo.Fpass, minfo.Apass, idealfcn);
this.Astop = measureattenuation(this, hfilter, minfo.Fstop, Fs/2, minfo.Astop);

% -------------------------------------------------------------------------
function H = defineideal(F, FreqFactor, Power, Fpass)

Fpass = Fpass(1);

H = 1./sinc(F*FreqFactor).^Power;

% Make sure that we don't apply the inverse sinc into the stopband.
indx = find(F > Fpass, 1, 'first');

if ~isempty(indx)
    H(indx+1:end) = H(indx);
end

% [EOF]
