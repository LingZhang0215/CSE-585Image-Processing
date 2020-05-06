function [out] = h1(x, sigma, F, theta)
    g = 1/(2*pi*sigma^2)*exp(-0.5*x^2/sigma^2);
    out = g*exp(complex(0,2*pi*F*x*cosd(theta)));
end