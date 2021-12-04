function [S_jonswap] = jonswap_spectrum(f, Hs, Tp)
    % Computes JONSWAP Power Spectrum Density from frequencies

    % Parameters
    % ----------
    % f: double (Nx1) vector
    %       frequencies to compute the spectrum
    % Hs: double scalar
    %       estimated Significant Wave Height
    % Tp: double scalar
    %       estimated Peak Period
    %
    % Returns
    % ----------
    % S_jonswap: double (Nx1) vector
    %       Power Spectrum Densities calculated from JONSWAP method

    fp = 1 / Tp;
    D = 0.036 - 0.0056 * Tp / sqrt(Hs);
    gama = exp(3.484 * (1 - 0.1975 * D * Tp^4 / (Hs^2)));
    beta = (0.0624 * (1.094 - 0.01915 * log(gama))) / (0.23 + 0.0336 * gama - 0.185 * (1.9 + gama)^(-1));

    S_jonswap = zeros(1, length(f));

    for i = 1:length(S_jonswap)

        if f(i) <= fp
            sigma = 0.07;
        elseif f(i) >= fp
            sigma = 0.09;
        endif

        S_jonswap(i) = beta * Hs^2 * Tp^(-4) * f(i)^(-5) * exp(-1.25 * (Tp * f(i))^(-4)) * gama^exp(-((Tp * f(i) - 1)^2) / 2 * sigma^2);
    endfor

endfunction
