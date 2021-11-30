close all
clear
clc

file_path = '../../W200908311900.tsr'; % Path from file to be analysed
file_data = load(file_path); % Import buoy observations
heaves = file_data(:, 2); % Keep only information about heave motion of the buoy

% Make the time-series to be composed by a number of samples multiple of 2
% Not strictly necessary for the FFT algorithm, but helps in the definition
% of windows for the Bartlett and Welch's methods
if mod(length(heaves), 2) == 1
    heaves(length(heaves)) = [];
end

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
xlabel("w [rad/s]");
ylabel("S [m^2*s]");
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part 2.3 - Noise reduction with a) Daniell's, b) Barlett's and c) Welch's method
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% a) Daniell's method

% b) Barlett's method
n_degrees_freedom_barlett = 2;
n_windows_barlett = fix(length(heaves) / (n_degrees_freedom_barlett / 2));
n_overlap_barlett = 0;
[S_barlett, f_barlett] = spectrum(heaves, length(heaves), n_overlap_barlett, hanning(n_windows_barlett), 1 / dt);
S_barlett = 2 * dt * S_barlett(:, 1);
% Plot
figure("name", "Power Spectrum Density using Barlett Method");
plot(f_barlett, S_barlett);
title("Power Spectrum Density using Barlett Method");
xlabel("w [rad/s]");
ylabel("S [m^2*s]");

% c) Welch's method
n_degrees_freedom_welch = 40;
n_windows_welch = fix(length(heaves) / (n_degrees_freedom_welch / 2));
percentage_overlapping_welch = 50;
n_overlap_welch = round(n_windows_welch * percentage_overlapping_welch / 100);
[S_welch, f_welch] = spectrum(heaves, length(heaves), n_overlap_welch, hanning(n_windows_welch), 1 / dt);
S_welch = 2 * dt * S_welch(:, 1);
% Plot
figure("name", "Power Spectrum Density using Welch Method");
plot(f_welch, S_welch);
title("Power Spectrum Density using Welch Method");
xlabel("w [rad/s]");
ylabel("S [m^2*s]");

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part 2.4 - Spectral Parameters from Spectrum obtained with Welch's method
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
delta_t = dt * length(heaves); % Time domain in seconds
% a) First 4 spectral moments
m0 = sum(S_welch) * (1 / delta_t);
m1 = sum(f_welch .* S_welch) * (1 / delta_t);
m2 = sum(f_welch.^2 .* S_welch) * (1 / delta_t);
m3 = sum(f_welch.^3 .* S_welch) * (1 / delta_t);
% disp(m0);
% disp(m1);
% disp(m2);
% disp(m3);

% b) Spectral Bandwidth Coefficient
spectral_bandwidth_coeff = (m0 * m2 - m1^2) / m1^2;

% c) Peak Period (Tp) and Significant Wave Height (Hs) from spectrum
[_ peak_energy_index] = max(S_welch); % Peak of the energy spectrum
Fp = f_welch(peak_energy_index); % Corresponding peak frequency in hertz
Tp = 1 / Fp; % Peak period in seconds
Hs = 4 * sqrt(m0); % Significant Height in meters
fprintf("Significant Height is: %f \n", Hs);

% d) Significant Wave Height comparison with time domain analysis

% This value is manually inserted. This value can be obtained by
% running index.m function of part_one an seeing the significant
% height value displayed in the console/terminal
Hs_time_domain = 1.92584;
Hs_percentual_discrepancy = 100 * abs(Hs_time_domain - Hs) / Hs_time_domain;
fprintf("Percentual Discrepancy between Hs is: %f\n", Hs_percentual_discrepancy);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part 2.5 - Comparing obtained Power Spectrum with Theoretical Spectral Model
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
