close all
clear
clc

sample_data = load('../../W200908311900.tsr'); % Import buoy observations
heaves = sample_data(:, 2); % Keep only information about heave motion of the buoy

dt = 0.78; % Sample time-interval between heave measurements
fs = 1/0.78; % Sample frequency

zero_crossing(heaves, fs);
