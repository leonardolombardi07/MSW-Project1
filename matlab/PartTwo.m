close all
clear
clc

filePath = '../W200908311900.tsr'; % Insert here the name of the file that you want to analyse, e.g. 'W200908010100.tsr'
data = load(filePath); % Import buoy observations
heaves = data(:, 2); % Keep only information about heave motion of the buoy

% Make the time-series to be composed by a number of samples multiple of 2
% Not strictly necessary for the FFT algorithm, but helps in the definition
% of windows for the Bartlett and Welch's methods
if mod(length(heaves), 2) == 1
    heaves(length(heaves)) = [];
end

n = length(heaves); % Number of samples (observations)
dt = 0.78; % Sampling interval

% Play with the two values below to adjust the configuration of Bartlett and Welch's methods
n_windows = 4; % Define the number of winows; if 0 or 1, the full series is analysed
percentage_overlapping = 50; % Define percentage of overlapping; if zero no overlapping

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not change the next four rows
n_members_windows = length(heaves) / n_windows;
noverlap = round(n_members_windows * percentage_overlapping / 100);
[S, f] = spectrum(heaves, length(heaves), noverlap, hanning(n_members_windows), 1 / dt);
S = 2 * dt * S(:, 1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Variable S contains the spectrum, variable f the frequency (in Hz)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
