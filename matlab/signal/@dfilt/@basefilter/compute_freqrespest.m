function [H,w] = compute_freqrespest(this,L,varargin)
%COMPUTE_FREQRESPEST   

%   Author(s): R. Losada
%   Copyright 2006 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2007/12/14 15:07:22 $

if L ~= round(L) || L < 1,
    error(generatemsgid('invalidNTrials'),'The number of trial must be a positive integer.');
end

opts = uddpvparse('dspopts.pseudospectrum', {'freqrespopts', this}, varargin{:});

if ishalfnyqinterval(opts),
    M = 2*opts.NFFT;
else
    M = opts.NFFT;
end

[VP,Yp] = nlminputnoutput(this,L,M);

H = Yp./VP;

H = H(1:opts.NFFT);

if opts.CenterDC,
    H = fftshift(H);
end

% Make sure to return a column
H = H(:);

if nargout > 1,
    w = generate_freq(opts);
end

%--------------------------------------------------------------------------
function w = generate_freq(opts)

if opts.NormalizedFrequency,
    Fs = [];
else
    Fs = opts.Fs;
end

if ishalfnyqinterval(opts),
    s = 2;
elseif opts.CenterDC,
    s = 3;
else
    s = 1;
end

w = freqz_freqvec(opts.NFFT, Fs, s);

% Make column
w = w(:);


% [EOF]
