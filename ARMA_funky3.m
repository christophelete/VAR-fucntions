function y = ARMA_funky3(T,sigma2, AR, MA, roots)
%ARMA Funky
% AR : row vector of AR coefficients. E.g. y_t = a1y_t-1 + a2y_t
% MA : row vector of MA coefficients
% Example: for the process:
% y_t = a1*y_t-1 + a2*y_t-2 + a3*y_t-2  + e_t + b1*e_t-1 + b2*e_t-2
% implies AR = [a1 a2 a3] ; MA = [b1 b2]
% If there are either no AR or MA coefficients, enter an empty vector AR = [] or MA =
% [], respectively.
% Instead of coefficients, also accept roots of AR and MA. In this case, vectors inputs for AR or MA are roots. The
% roots are presumed to be the roots of the characteristic equations in L
% notation
% If there is either no AR or MA roots, enter an empty vector AR = [] or MA =
% [], respectively.
% If your input for AR, and MA are vectors of roots of the respective characteristic equations,
% you must indicate roots = true. If your input for AR and MA are vectors
% of coefficients, you must indicate roots = false

if (roots == true)
    if length(AR) > 0
        AR = poly(1./AR);
        AR = AR(2:length(AR));
    end
    if length(MA) > 0
        MA = poly(1./MA);
        MA = MA(2:length(MA));
    end 
end

y = zeros(T,1);
e = randn(T,1)*sqrt(sigma2);
y(1) = e(1);

numcoeffar = length(AR);
numcoeffma = length(MA);

if (numcoeffar == 0)
    AR = 0;
end

for t= 2:T

    try
        sum_ar = sum ( AR(1: t-1) * flip(y(1:t-1)) );
    catch
        sum_ar = sum( flip(AR) * y(t - numcoeffar: t -1) );
    end
    
    try
        sum_ma = sum ( MA(1: t- 1) * flip(e(1:t -1)) );
    catch
        sum_ma = sum( flip( MA ) * e(t - numcoeffma: t -1) );
    end
    y(t) = sum_ar + sum_ma + e(t);

end

