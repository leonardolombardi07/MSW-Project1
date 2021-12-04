function densities = longuet_higgins(heaves)
    % Expected Longuet-Higgins distribution densities from vector of measured buoy heaves

    % Parameters
    % ----------
    % heaves: double (Nx1) vector
    %       heave measurements
    %
    % Returns
    % ----------
    % densities: double (Xx1) vector
    %       Longuet-Higgins Probability Density Function applied to each heave
    %

    extreme_kurt = kurtosis(heaves) - 3;
    skew = skewness(heaves);
    standard_dev = std(heaves);

    x = heaves / standard_dev;
    H3 = x.^3 - 3 * x;
    H4 = x.^4 - 6 * x.^2 + 3;
    H6 = x.^6 - 15 * x.^4 + 45 * x.^2 - 15;

    normal_dist = normpdf(heaves, mean(heaves), standard_dev);
    densities = normal_dist .* (1 + (skew / 6) * H3 + (skew^2/72) * H6 + (extreme_kurt / 24) * H4);
endfunction
