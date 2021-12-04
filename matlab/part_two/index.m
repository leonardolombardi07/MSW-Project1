close all
clear
clc

sample_data = load("../../W200908311900.tsr"); % Import buoy observations
heaves = sample_data(:, 2); % Keep only information about heave motion of the buoy

% Make the time-series to be composed by a number of samples multiple of 2
% Not strictly necessary for the FFT algorithm, but helps in the definition
% of windows for the Bartlett and Welch's methods
if mod(length(heaves), 2) == 1
    heaves(length(heaves)) = [];
endif

n = length(heaves); % Number of samples (observations)
dt = 0.78; % Sampling interval

% The two values below adjust the configuration of Bartlett and Welch's methods
n_windows = 4; % Define the number of windows; if 0 or 1, the full series is analysed
percentage_overlapping = 50; % Define percentage of overlapping; if zero no overlapping

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part 2.2 - Power Spectrum from FFT (Fast Fourrier Transform)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Do not change the next four rows
n_members_windows = length(heaves) / n_windows;
noverlap = round(n_members_windows * percentage_overlapping / 100);
[S, f] = spectrum(heaves, length(heaves), noverlap, hanning(n_members_windows), 1 / dt);
S = 2 * dt * S(:, 1); % Variable S contains the spectrum, variable f the frequency (in Hz)
% Plot
figure("name", "Power Spectrum Density from FFT");
plot(f, S);
title("Power Spectrum Density from FFT");
xlabel("f [Hz]");
ylabel("S [m^2/Hz]");
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part 2.3 - Noise reduction with a) Daniell's, b) Barlett's and c) Welch's method
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% a) Daniell's method
S_daniell = S;
% We reduce noise (but increase bias) by smoothing the spectrum
% "p" determines "how far" we are going to average the spectrum values
p = 20;

for i = (p + 1):length(S_daniell) - p
    S_daniell(i) = sum(S_daniell(i - p:i + p)) / (2 * p + 1);
endfor

% Plot
figure("name", "Power Spectrum Density using Daniell Method");
plot(f, S_daniell);
title("Power Spectrum Density using Daniell Method");
xlabel("f [Hz]");
ylabel("S [m^2/Hz]");

% b) Barlett's method
n_degrees_freedom_barlett = 24;
n_windows_barlett = fix(length(heaves) / (n_degrees_freedom_barlett / 2));
n_overlap_barlett = 0;
[S_barlett, f_barlett] = spectrum(heaves, length(heaves), n_overlap_barlett, hanning(n_windows_barlett), 1 / dt);
S_barlett = 2 * dt * S_barlett(:, 1);
% Plot
figure("name", "Power Spectrum Density using Barlett Method");
plot(f_barlett, S_barlett);
title("Power Spectrum Density using Barlett Method");
xlabel("f [Hz]");
ylabel("S [m^2/Hz]");

% c) Welch's method
n_degrees_freedom_welch = 40;
n_windows_welch = fix(length(heaves) / (n_degrees_freedom_welch / 2));
percentage_overlapping_welch = 50; # For hanning windowing, this is the recommended value
n_overlap_welch = round(n_windows_welch * percentage_overlapping_welch / 100);
[S_welch, f_welch] = spectrum(heaves, length(heaves), n_overlap_welch, hanning(n_windows_welch), 1 / dt);
S_welch = 2 * dt * S_welch(:, 1);
% Plot
figure("name", "Power Spectrum Density using Welch Method");
plot(f_welch, S_welch);
title("Power Spectrum Density using Welch Method");
xlabel("f [Hz]");
ylabel("S [m^2/Hz]");

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part 2.4 - Spectral Parameters from Spectrum obtained with Welch's method
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
delta_t = dt * length(heaves); % Time domain in seconds
% a) First 4 spectral moments
m0 = sum(S_welch) * (1 / delta_t);
m1 = sum(f_welch .* S_welch) * (1 / delta_t);
m2 = sum(f_welch.^2 .* S_welch) * (1 / delta_t);
m3 = sum(f_welch.^3 .* S_welch) * (1 / delta_t);

spectral_moments = [m0, m1, m2, m3];

for i = 1:length(spectral_moments)
    fprintf("Spectral Moment %d is: %f \n", i, spectral_moments(i));
endfor

% b) Spectral Bandwidth Coefficient
spectral_bandwidth_coeff = sqrt((m0 * m2 - m1^2) / m1^2);
fprintf("Spectral Bandwidth Coefficient is: %f \n", spectral_bandwidth_coeff);

% c) Peak Period (Tp) and Significant Wave Height (Hs) from spectrum
[_ peak_energy_index] = max(S_welch); % Peak value from spectrum
Fp = f_welch(peak_energy_index); % Corresponding peak frequency in hertz
Tp = 1 / Fp; % Peak period in seconds
fprintf("Peak Period is: %f \n", Tp);
Hs = 4 * sqrt(m0); % Significant Height in meters
fprintf("Significant Height is: %f \n", Hs);

% d) Significant Wave Height comparison with time domain analysis

% This value must be manually inserted. It can can be obtained by
% running index.m function of part_one an seeing the significant
% height value displayed in the console/terminal
Hs_time_domain = 1.92584;
Hs_percentual_discrepancy = 100 * abs(Hs_time_domain - Hs) / Hs_time_domain;
fprintf("Percentual Discrepancy between Hs in time domain and frequency domain is: %f\n", Hs_percentual_discrepancy);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part 2.5 - Comparing obtained Power Spectrum with Theoretical Spectral Model
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Calculating Jonswap Spectrum
[S_jonswap] = jonswap_spectrum(f_welch, Hs, Tp);

% Plot
figure("name", "Power Spectrum Density of heaves comparison: JONSWAP model against Welch method");
plot(f_welch, S_jonswap);
hold on;
plot(f_welch, S_welch);
legend("JONSWAP", "Welch")
title("Power Spectrum Density of heaves comparison: JONSWAP model against Welch method");
xlabel("f [Hz]");
ylabel("S [m^2/Hz]");
