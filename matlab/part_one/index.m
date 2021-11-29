close all
clear
clc

file_path = '../../W200908311900.tsr'; % Path from file to be analysed
file_data = load(file_path); % Import buoy observations
heaves = file_data(:, 2); % Keep only information about heave motion of the buoy

frequency = 1/0.78

zero_crossing(heaves, frequency);
