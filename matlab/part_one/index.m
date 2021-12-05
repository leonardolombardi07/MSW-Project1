close all
clear
clc

sample_data = load("../../W200908311900.tsr"); % Import buoy observations
times = sample_data(:, 1);
heaves = sample_data(:, 2); % Keep only information about heave motion of the buoy

dt = 0.78; % Sample time-interval between heave measurements
fs = 1/0.78; % Sample frequency

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part 1.1 - Mean, dispersion (variance), skewness, and kurtosis (first four moments)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
heaveMean = mean(heaves);
heaveVariance = var(heaves);
heaveSkewness = skewness(heaves);
heaveKurtosis = kurtosis(heaves);

probabilistic_moments = [heaveMean, heaveVariance, heaveSkewness, heaveKurtosis];

for i = 1:length(probabilistic_moments)
    fprintf("Probabilistic Moment %d is: %f \n", i, probabilistic_moments(i));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part 1.2 - Distribution of Heaves
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% We are going to compare empirical obtained heaves with Gaussian and
% Longuet-Higgins distributions. "heaves" data comes in a unsorted way
% (like [-0.3, 0.1, -0.15, ...]). To compare with the empirical heaves histogram
% we need to sort from smallest to biggest value (like [-0.3, -0.15, 0.1, ...])
sorted_heaves = sort(heaves);

normal_dist = normpdf(sorted_heaves, heaveMean, std(heaves));
longuet_higg = longuet_higgins(sorted_heaves);

% Plot
figure("name", "Comparing Gaussian and Longuet Higgins distributions to empirical distribution of heaves");
[counts, centers] = hist(heaves);
bar(centers, counts / sum(counts * diff(centers(1:2))), 1);
hold on;
plot(sorted_heaves, normal_dist);
hold on;
plot(sorted_heaves, longuet_higg);
title("Comparing Gaussian and Longuet Higgins distributions to empirical distribution of heaves")
legend("Empirical", "Gaussian", "Longuet-Higgins");
ylabel ("Density");
xlabel("Heave [m]");

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part 1.3 - Identify Up-crossing and Down-crossing individual waves and associated periods
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Up-Crossing

% Obtaining the heights and periods
[up_crossing_periods, up_crossing_heights] = zero_crossing(times, heaves, 2);

% Empirical Histogram data
[counts, centers] = hist(up_crossing_heights);

% We are going to compare wave heights obtained with zero crossing method with
% Rayleigh distribution. Both up and down crossing obtained heights will be
% unsorted (like [1.5, 2, 1.3, ...]). To compare with the wave heights histogram
% we need to sort from smallest to biggest value (like [1.3, 1.5, 2 ...])
sorted_up_crossing_heights = sort(up_crossing_heights);
rayleigh_up = rayleigh(sorted_up_crossing_heights);

% Plot
figure("name", "Comparing Rayleigh distribution to empirical distribution of Wave Heights for zero up-crossing analysis");
bar(centers, counts / sum(counts * diff(centers(1:2))), 1); % Empirical
hold on;
plot(sorted_up_crossing_heights, rayleigh_up);
ylabel ("Density");
xlabel("Wave Height [m]");
legend("Empirical", "Rayleigh")

% Down-Crossing

% Obtaining the heights and periods
[down_crossing_periods, down_crossing_heights] = zero_crossing(times, heaves, -2);

% Empirical Histogram data
[counts, centers] = hist(down_crossing_heights);

sorted_down_crossing_heights = sort(down_crossing_heights);
rayleigh_down = rayleigh(sorted_down_crossing_heights);

% Plot
figure("name", "Comparing Rayleigh distribution to empirical distribution of Wave Heights for zero down-crossing analysis");
bar(centers, counts / sum(counts * diff(centers(1:2))), 1); % Empirical
hold on;
plot(sorted_down_crossing_heights, rayleigh_down);
ylabel ("Density");
xlabel("Wave Height [m]");
legend("Empirical", "Rayleigh");

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part 1.4 - Significant wave height and significant wave period
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Up-crossing
mean_height_up = mean(up_crossing_heights);
max_height_up = max(up_crossing_heights);
[significant_period_up, significant_height_up] = get_significant_stats(up_crossing_periods, up_crossing_heights);
disp("For Up-Crossing:");
fprintf("Significant Period is: %f \n", significant_period_up);
fprintf("Mean Height is: %f \n", mean_height_up);
fprintf("Maximum Height is: %f \n", max_height_up);
fprintf("Significant Height is: %f \n", significant_height_up);

% Down-crossing
mean_height_down = mean(up_crossing_heights);
max_height_down = max(up_crossing_heights);
[significant_period_down, significant_height_down] = get_significant_stats(down_crossing_periods, down_crossing_heights);
disp("For Down-Crossing:");
fprintf("Significant Period is: %f \n", significant_period_down);
fprintf("Mean Height is: %f \n", mean_height_down);
fprintf("Maximum Height is: %f \n", max_height_down);
fprintf("Significant Height is: %f \n", significant_height_down);
