function [B_copy,B_exo, my3D, Y_hat, constant, resid, vcov] = estVAR_with_exo(nlags,Y, exo, c)
%Estimate VAR by Multivariate Least Squares
% Y is (Txn) matrix where n is the number of variables in the series for
% each time t
% exo: series of exogenous series
% OUTPUT: Matrix of coefficient: B is (r x n) where is r the total number of
% regressors. Naturally, in a VAR r = n*nlags
% c: constant. For constant, put c = 1. If no constant, put c =0
% B_exo is a matrix of coefficients for the exogenous variables
% my3D is a trezor of coefficients, used for conventional VAR representation of lags
% variables
%B_copy is the multivariate least squares output representation of all
%coefficients
% representation:
%For example, assuming VAR(3), then it holds:
% Yt = my3D(:,:,1) Y_t-1 + my3D(:,:,2) Y_t-2 + my3D(:,:,3) Y_t-3 + e_t
% With constant:  Yt = constant + my3D(:,:,1) Y_t-1 + my3D(:,:,2) Y_t-2 + my3D(:,:,3) Y_t-3 + e_t


%Adjustments of data due to lags
X = [];
for i=1:nlags
    X = [X Y(nlags-i+1: end -i, :)];

end


[row col ] = size(exo);

if isempty(exo)
    X = X;
else
    X = [ exo(nlags +1: end,:) X ];
end

%%%%%%To 'constant' or not to 'constant'

if c==1
    X = [ones((size(Y,1)-nlags),1) X];
end


Y = Y(nlags+1: end, :);



% Multivariate Least Squares
B = inv( X'* X )* X'*Y;

% Others important statistics
Y_hat = X*B;
resid = Y - Y_hat;
% vcov = (resid' * resid)/ (length(Y));
vcov = (resid' * resid)/ (length(Y) - size(Y,2)); %Adjustment for lost of degrees of freedom;unbiased


%Conventional Representation of VAR

B_copy = B;
if c ==1
    constant = B(1,:)';
    BB = B(2: end, :);
else
    constant = 'User specified no constant. Set c =1 if constant is desired';
end 

if isempty(exo) ==0 
    B_exo = B(c+1:col+ c,:)';
    if c ==1
        BB = B(col +c +1:end, :);
    elseif c ==0
        B = B(col +1:end, :);
    end
        
end

num_n = size(Y,2);

dim = 1;
for i= 1:(num_n):(nlags)*num_n
    if c ==1
        lag_component = BB(i:i+(num_n-1),:);

    else
        lag_component = B(i:i+(num_n-1),:);
    end

    my3D(:,:,dim) = lag_component';
    dim = dim +1;
end


    

end