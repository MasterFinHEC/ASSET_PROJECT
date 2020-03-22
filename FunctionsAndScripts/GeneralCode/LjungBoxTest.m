%==========================================================================
% Advanced Econometrics, HEC Lausanne
% Portmanteau (Ljung-Box) test for serial correlation
%--------------------------------------------------------------------------
% Author: Daria Kalyaeva
% Version: November 2014
%==========================================================================
% INPUTS
% X         a vector of time series data points;
% K         number of lags;
% s         number of estimated parameters (p+q for residuals of ARMA(p,q) 
%           models)
% alpha     the significance level, a value between 0 and 1.
%
% OUTPUT
% LBResult     a dataset variable with the LM statistic, the
%                       critical value at the specified confidence level,
%                       and the p-value
%
%
% Requires installation of Kevin Sheppard's MFE Toolbox


function LBresult = LjungBoxTest(X,K,s,alpha)

% Calculate autocorrelations
[rho,~] = sacf(X,K,1,0);

% Define parameters
n = length(X);
rho2 = rho.^2;

% Statistic for Ljung Box
QLBstat = n*(n+2)*sum(rho2./(ones(K,1)*n - (1:K)'));
df = K-s;
LBCritVal = chi2inv(1-alpha,df);
LBpValue = 1 - chi2cdf(QLBstat,df);


% Output
LBresult = [QLBstat,LBCritVal,LBpValue];
   %'Qstat','CriticalValue','pValue'},...
   %'ObsNames',{'Ljung-Box'});



end

