function densities = rayleigh(heights)
    % Expected Rayleigh distribution densities from vector of individual wave heights

    % Parameters
    % ----------
    % heights: double (Nx1) vector
    %       individual wave heights
    %
    % Returns
    % ----------
    % densities: double (Xx1) vector
    %       Rayleigh Probability Density Function applied to each height
    %
    % See Also:
    % ----------
    % Possible formulations of Rayleigh Distribution from individual wave heights
    % https://www.usna.edu/NAOE/_files/documents/Courses/EN330/Rayleigh-Probability-Distribution-Applied-to-Random-Wave-Heights.pdf

    mean_height_squared = mean(heights)^2;
    exponential = exp((-pi / (4 * mean_height_squared)) .* (heights.^2));
    densities = ((pi / (2 * mean_height_squared)) .* heights) .* exponential;
endfunction
