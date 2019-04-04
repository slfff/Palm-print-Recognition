function [R] = G(x, y, theta, mu, sigma, beta)

%%%%%%%%%%%%%%%%%%%%%%% Lingfei Song 2018.5.3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Kernel of revised Gabor filter 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[rows, cols] = size(x);

x_ = x * cos(theta) + y * sin(theta);
y_ = -x * sin(theta) + y * cos(theta);
R = exp(-1*(x_.^2/sigma^2 + y_.^2/beta^2)) .* cos(2*pi*mu.*x_) - (sigma^2 * pi * exp(-pi^2 * sigma^2 * mu^2))/(rows*cols);
