function [significant_period, significant_height] = get_significant_stats(periods, heights)
    % Computes significant wave period and significant wave height

    % Parameters
    % ----------
    % periods: double (Xx1) vector
    %       periods of individual waves
    % heights: double (Xx1) vector
    %       heights of individual waves
    %
    % Returns
    % ----------
    % significant_period: double scalar
    %       Significant Wave Period for set of periods and heights
    % significant_height: double scalar
    %       Significant Wave Height for set of periods and heights
    %
    % See Also:
    % ----------
    % Wikpedia definition:
    % https://en.wikipedia.org/wiki/Significant_wave_height#:~:text=Nowadays%20it%20is%20usually%20defined,area)%20of%20the%20wave%20spectrum.

    [sorted_heights, indexes] = sort(heights, "descend");
    top_third = round(length(sorted_heights) / 3);

    significant_height = mean(sorted_heights(1:top_third));
    significant_period = mean(periods(indexes)(1:top_third));

endfunction
