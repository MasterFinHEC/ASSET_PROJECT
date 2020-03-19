function [WeightsOpti] = RiskParityOpti(Signal,Weights,Returns,Target)
%Optimisation of the Risk parity Weighting Scheme

%   This function take the following Inputs:

% *************************************
% INPUT
% *************************************

% Signal :  A matrix of assets X number of position dimension of long/short signal
% Weights : A matrix of assets X number of position dimension of weights computed through
%           the volatility parity weighting scheme. They are the initial
%           point for the optimisation at each period. 
% Returns : A matrix of assets X time dimension of returns to compute the 
%           matrix of variance / covariance. 
% Target :  A volatility target to compute the volatility constraint. 

% This yield the following output : 

% *************************************
% OUTPUT
% *************************************

% WeightsOpti : A matrix of assets X number of position of optimal weights
%               through the risk parity weighting scheme.

% *************************************
% Function
% *************************************

%Setting some parameters allowing the reproductibility of the function
asset = size(Returns,2); %Number of assets - for the loops

%Computing the NetWeights that will be the initial point of optimisation
NetWeights = Signal.*Weights; % Long/short weights of VolParity 

%Setting the size of the output. 
WeightsOpti = zeros(round((length(Returns)-252)/20,0),asset); %Size of the output 

%Setting the unused parameters of the optimisation (matlab obligates it)
A = []; %No linear constraint
b = []; %No linear constraint
Aeq = []; %No Bounds on the linear constraint
beq = []; %No Bounds on the linear constraint
lb = []; %No Bounds on the weights
ub = []; %No Bounds on the weights

%Disabling useless Warnings during optimisation
warning ( 'off' , 'MATLAB:nearlySingularMatrix')

%Setting a position index allowing to move month by month on the matrix
position = 1; %Position Index

% *************************************
%Loop optimizing the weights for each month
%   Starting after a year (Initial Signal) 
%   Every 20 days (a month) - period of rebalancing
%   Until the end of the return.
% *************************************
disp('Optimisation is starting !')
    for i = 253:20:length(Returns) 
        
        if position == round(round((length(Returns)-252)/20,0)/10,0)
            disp('10% Done')
        elseif position == round(round((length(Returns)-252)/20,0)/3,0)
            disp('30% Done')
        elseif position == round(round((length(Returns)-252)/20,0)/2,0)
            disp('50% Done')
        elseif position == round(round((length(Returns)-252)/20,0)*3/4,0)
            disp('75% Done')
        else %do nothing
        end% Just print the position to know where we are withing the optimisation
        
        % Finding the available asset to perform logical indexing on the
        % optimization
        index = Weights(position,:)~=0;  % Vector of 1 if the initial weights is not equal to zero and 0 otherwise. 
                                         % So there is no need to perform
                                         % to check wheter the assets are
                                         % available 252 days from now
                                         % (Already done).
       
                                         
        % Setting the objective function (anonyme function)
        fun = @(x)sum(log(abs(x))); %Function going over the available assezs (index == 1)
        
        % Finding the 60 days covariance matrix
        CovMat = cov(Returns(i-60:i,index==1)); %Covariance of the available assets (index == 1)
                                       
        % Setting the non-linear (volatility) constraint
        %nonlcon = @VolConstraint;
        %@(x)sqrt(x*CovMat*x') - Target; -> previous constraint
        
        options = optimoptions('fmincon','Display','off');
        
        % Optimizing the month's weights 
         WeightsOpti(position,index==1) = fmincon(fun,NetWeights(position,index==1),A,b,Aeq,beq,lb,ub,@(x) VolConstraint(x,Target,CovMat),options);
        
          %Rescaling Weights
        SumWeights = 0; 
        
        %Loop adding the existing weights
        for x = 1:asset
            if WeightsOpti(position,x) ~= 0
                SumWeights = SumWeights + WeightsOpti(position,x);
            end 
        end 
       
        %Finding the weights in %
        WeightsOpti(position,:) = WeightsOpti(position,:)*100/SumWeights;
         
        % Going for the next rebalancing 
        position = position + 1;
    end
    
    disp('Optimisation is finished !')
end

