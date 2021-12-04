function [periods, heights] = zero_crossing(times, heaves, direction)
    % Zero-crossing analysis of buoy heave data.

    % Parameters
    % ----------
    % times: double (Nx1) vector
    %       instants of heave measurement
    % heaves: double (Nx1) vector
    %       heave measurements for given times.
    % direction: string scalar
    %       "up" if using up-crossing, "down" if using down-crossing
    %       method.
    %
    % Returns
    % ----------
    % periods: double (Xx1) vector
    %       periods of zero-crossing individual waves identified
    % heights: double (Xx1) vector
    %       heights of zero-crossing individual waves identified
    %
    % See Also:
    % ----------
    % Article explaining zero-crossing algorithm:
    % https://www.usna.edu/NAOE/_files/documents/Courses/EN330/Random-Wave-Analysis.pdf

    detrended_heaves = detrend(heaves);
    signals = sign(detrended_heaves);
    diffs = diff(signals);

    if direction == "up"
        number_to_find = 2
    else
        number_to_find = -2
    endif

    crossing_indexes = find(diffs == number_to_find);

    periods = []; heights = [];

    for i = 1:length(crossing_indexes) - 1
        last_index = crossing_indexes(i);
        current_index = crossing_indexes(i + 1);

        periods(length(periods) + 1) = times(current_index) - times(last_index);
        wave_heaves = heaves(last_index:current_index);
        heights(length(heights) + 1) = max(wave_heaves) + abs(min(wave_heaves));
    endfor

endfunction
