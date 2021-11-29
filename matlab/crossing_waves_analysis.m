function [Hs, Ts] = crossing_waves_analysis(times, heaves)
    detrendedHeaves = heaves .- mean(heaves);
    heave_signals_diffs = diff(sign(detrendedHeaves));

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Down-Crossing analysis
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    downcross_indexes = find(heave_signals_diffs == -2);
    Td_wave = zeros(length(downcross_indexes) - 1, 1); % index of the crossing periods (down)
    Hd_wave = zeros(length(downcross_indexes) - 1, 1);

    for i = 2:length(downcross_indexes) - 1;
        Td_wave(i - 1) = times(downcross_indexes(i)) - times(downcross_indexes(i - 1));

        max_wave_height = max(detrendedHeaves(downcross_indexes(i - 1):downcross_indexes(i)));
        min_wave_height = min(detrendedHeaves(downcross_indexes(i - 1):downcross_indexes(i)));
        Hd_wave(i - 1) = max_wave_height - min_wave_height;
    end

    % Distribution of individual wave heights regarding Down-crossing
    sorted_H = sort(Hd_wave(:));
    histogram_bins = (min(sorted_H) - min(sorted_H):0.05:max(sorted_H) * 1.1);

    % Computing empirical densities (as bar and graph) and rayleigh distribution
    [bar_densities, bar_Hs] = hist(sorted_H, histogram_bins);
    empirical_densities = ksdensity(sorted_H, histogram_bins); % empirical density of the individual wave height distribution
    rayleigh_densities = raylpdf(sorted_H, raylfit(sorted_H)); % 95% confidence intervals

    % Ploting comparison between empirical density of individual wave height and raylegh distribution
    figure;
    subplot(2, 1, 2);
    bar(bar_Hs, bar_densities / sum(f * diff(bar_Hs(1:2))), 1); % Bar graph of the empirical distribution of individual wave heights (distribution)
    hold on
    plot(sorted_H, rayleigh_densities, 'g', 'Linewidth', 2.5);
    plot(histogram_bins, empirical_densities, 'r', 'Linewidth', 2.5);
    title(['Histogram - Height Distribuition Down']);
    xlabel('Individual Wave Height [m]');
    ylabel('Density');
    legend('Empirical distribution', 'Empirical distribution', 'Rayleigh distribution');
    hold off;

    # Down - Crossing Significant Wave Height
    descend_Hd = sort(Hd_wave(:), 'descend');
    biggest_onethird_Hd = round(length(Hd_wave(:)) / 3);
    Hs_Down = mean(descend_Hd(1:biggest_onethird_Hd));
    disp(['Sigficant wave height H_(1/3) down crossing [m]: ', num2str(Hs_Down)]);

    # Up - Crossing Significant Wave Period
    Ts_Down = [];

    for i = 1:length(Hd_wave(:));

        if Hd_wave(i) >= Hs_Down;
            Ts_Down = cat(2, Ts_Down, Td_wave(i));
        end

    end

    disp(['Sigficant wave period down crossing [s]: ', num2str(Ts_Down)]);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Up-Crossing analysis
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    upcross_indexes = find(heave_signals_diffs == 2);
    Tu_wave = zeros(length(upcross_indexes) - 1, 1);
    Hu_wave = zeros(length(upcross_indexes) - 1, 1);

    for i = 2:length(upcross_indexes) - 1;
        Tu_wave(i - 1) = times(upcross_indexes(i)) - times(upcross_indexes(i - 1));

        max_wave_height = max(detrendedHeaves(upcross_indexes(i - 1):upcross_indexes(i)));
        min_wave_height = min(detrendedHeaves(upcross_indexes(i - 1):upcross_indexes(i)));
        Hu_wave(i - 1) = max_wave_height - min_wave_height;
    end

    % Distribution of individual wave heights regarding Up-crossing
    sorted_H = sort(Hu_wave(:));
    histogram_bins = (min(sorted_H) - min(sorted_H):0.05:max(sorted_H) * 1.1);

    % Computing empirical densities (as bar and graph) and rayleigh distribution
    [bar_densities, bar_Hs] = hist(sorted_H, histogram_bins);
    empirical_densities = ksdensity(sorted_H, histogram_bins); % empirical density of the individual wave height distribution
    rayleigh_densities = raylpdf(sorted_H, raylfit(sorted_H)); % 95% confidence intervals

    % Ploting comparison between empirical density of individual wave height and raylegh distribution
    figure;
    subplot(2, 1, 2);
    bar(bar_Hs, bar_densities / sum(f * diff(bar_Hs(1:2))), 1); % Bar graph of the empirical distribution of individual wave heights (distribution)
    hold on;
    plot(sorted_H, rayleigh_densities, 'g', 'Linewidth', 2.5);
    plot(histogram_bins, empirical_densities, 'r', 'Linewidth', 2.5);
    title(['Histogram - Height Distribuition Up']);
    xlabel('Individual Wave Height [m]');
    ylabel('Density');
    legend('Empirical distribution', 'Empirical distribution', 'Rayleigh distribution');
    hold off;

    # Up - Crossing Significant Wave Height
    descend_Hu = sort(Hu_wave(:), 'descend');
    biggest_onethird_Hu = round(length(Hu_wave(:)) / 3);
    Hs_Up = mean(descend_Hu(1:biggest_onethird_Hu));
    disp(['Sigficant wave height H_(1/3) up crossing [m]: ', num2str(Hs_Up)]);

    # Up - Crossing Significant Wave Period
    Ts_Up = [];

    for i = 1:length(Hu_wave(:));

        if Hu_wave(i) >= Hs_Up;
            Ts_Up = cat(2, Ts_Up, Tu_wave(i));
        end

    end

    disp(['Sigficant wave period up crossing [s]: ', num2str(Ts_Up)]);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    Hs = [Hs_Up, Hs_Down];
    Ts = [Ts_Up, Ts_Down];
end
