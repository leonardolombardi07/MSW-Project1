%FREQUENCY DOMAIN%

n_degrees_free = 32; %n? of degrees of freedom
wind_welch = fix(length(surf) / (n_degrees_free / 2)); %Window size for Welch Method
%in order to have an even number
if mod(wind_welch, 2) == 1
    wind_welch = wind_welch - 1;
end

overlap = wind_welch / 2; %50% of overlap in Welch Method
nfft = fix(length(surf) / wind_welch) * wind_welch; % length of time series (number of discrete fourier transform points)
%in order to have an even number
np = mod(nfft, 2);

if np == 1
    nfft = nfft - 1;
end

DDT = DT * nfft; %time domain in seconds in discrete mode
freq_vector = (0:1 / (nfft * DT):1 / (2 * DT)); %frequency vector
freq_vector = freq_vector';

%%%%Power spectrum
%Changes were made
%plot(freq_vector(1:1000),spectrum_vector(1:1000),'k','Linewidth',2.5);
%was swapped by
%plot(freq_vector,spectrum_vector,'k','Linewidth',2.5);

%Spectrum calculated dividing the time series by (length(a)/nw) - according to Welch Method
spectrum_vector = spectrum (surf, nfft, overlap, hanning(wind_welch), 1 / DT);
%taking the real part only and multiplying by DT
spectrum_vector = 2 * DT * spectrum_vector(:, 1);
figure;
plot(freq_vector, spectrum_vector, 'k', 'Linewidth', 2.5);
ylabel('Power Variance');
hold on

[svmax indice] = max(spectrum_vector); %peak of the energy spectrum
fp = freq_vector(indice(1)); %peak frequency in hz
tp = 1 / fp%peak period in seconds

%Spectral momenta m_n
m0 = sum(spectrum_vector) * (1 / DDT); %zeroth
m1 = sum(freq_vector .* spectrum_vector) * (1 / D

); %first
m2 = sum(freq_vector.^2 .* spectrum_vector) * (1 / DDT); %second
m3 = sum(freq_vector.^3 .* spectrum_vector) * (1 / DDT); %thrid
hs = 4 * sqrt(m0)%significant wave heigth by the spectrum
hm = 2.51 * sqrt(m0); %mean wave height by the spectrum

VMTA = sum(spectrum_vector .* (1 / DDT))
VMTB = sum(freq_vector .* spectrum_vector)
VMTC = sum(freq_vector.^2 .* spectrum_vector)
VMTD = sum(freq_vector.^3 .* spectrum_vector)
VMTE = sum(freq_vector.^4 .* spectrum_vector)
HS = 4 * sqrt(VMTA)%Significant wave heigth

coefficient = (m0 * m2 - m1^2) / m1^2

%%%%%Jonswap Power Spectrum
D = 0.036 - 0.0056 * tp / sqrt(hs);
gama = exp(3.484 * (1 - 0.1975 * D * tp^4 / (hs^2)))
beta = (0.0624 * (1.094 - 0.01915 * log(gama))) / (0.23 + 0.0336 * gama - 0.185 * (1.9 + gama)^(-1));

for i = 1:length(freq_vector)

    if freq_vector(i) <= fp
        stdea = 0.07;
    elseif freq_vector(i) >= fp
        stdea = 0.09;
    end

    jonswap(i) = beta * hs^2 * tp^(-4) * freq_vector(i)^(-5) * exp(-1.25 * (tp * freq_vector(i))^(-4)) * gama^exp(-((tp * freq_vector(i) - 1)^2) / 2 * stdea^2);
end

jonswap = jonswap';
plot(freq_vector, jonswap, 'y', 'Linewidth', 2.5);
axis([0, 0.6, 0, 70]);
legend('Energy Spectrum (Welch Method)', 'Jonswap Spectrum')
title('Energy Spectrum - Wavebuoy')
xlabel('Frequency [Hz]');
ylabel('S(f) [m^2/Hz]');
