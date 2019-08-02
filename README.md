# VAR-functions

-The ARMA_funky3 function generates an ARMA process with the specified AR (autoregressive component) and MA (moving-average component) characteristics, as well as the duration.The number of components of AR and MA can be specified without any limit (of course, as long as it holds in memory and does not overflow).

-The OLSregression function utilizes ordinary-least squares (OLS) to estimate the regression. 

-The estVAR function is based on OLS but for vectors with its own lags (autoregressive components) as explanatory variables, allowing to perform the estimation for multiple equations simultaneously, while also allowing the interactive effects between equations

-The estVAR_with_exo is simply the estVAR function, but also allows a use-specified exogenous variable for greater flexibility
