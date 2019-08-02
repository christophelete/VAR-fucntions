function [b, cov_b] = OLSregression(y,x)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

b = inv(x'*x) *x' *y;

e = y-x*b;

sigma2_hat = e'*e/(length(y)-size(x,2));

cov_b = inv(x'*x)*sigma2_hat;


end

