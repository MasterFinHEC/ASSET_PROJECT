function [WeightsOpti] = RiskParityOpti(Signal,Weights,Returns,Target,LengthSignal,LengthVol,LengthMonth)
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
WeightsOpti = zeros(round((length(Returns)-LengthSignal)/LengthMonth,0),asset); %Size of the output 

%Setting the unused parameters of the optimisation (matlab obligates it)
A = []; %No linear constraint
b = []; %No linear constraint

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

    for i = LengthSignal+1:LengthMonth:length(Returns) 
        
        % Finding the available asset to perform logical indexing on the
        % optimization
        index = Weights(position,:)~=0;  % Vector of 1 if the initial weights is not equal to zero and 0 otherwise. 
                                 
        % Setting the objective function (anonyme function)
        fun = @(x) -(sum(log(abs(x)))); %Function going over the available assets (index == 1)
        
        % Finding the LengthVol days covariance matrix
        CovMat = cov(Returns(i-LengthVol+1:i,index==1)); %Covariance of the available assets (index == 1)
        
        % Setting optimisation bounds on weights ->  can take leverage on an
        % asset
        lb = [];
        ub = [];
      % lb = ones(1,length(CovMat))*-1; 
       %ub = ones(1,length(CovMat));
 
        
        % Setting linear constraint (Sum of weights = 100%)
        Aeq = ones(1,length(CovMat));
        beq = 1;
        
        % Setting options
        options = optimoptions(@fmincon,'Algorithm','interior-point',...
    'MaxIterations',100000,'ConstraintTolerance',1.0000e-6, ...
    'OptimalityTolerance',1.0000e-6,'MaxFunctionEvaluations',...
    100000,'Display','none');
   
        
        % Optimizing the month's weights 
         WeightsOpti(position,index==1) = fmincon(fun,NetWeights(position,index==1),A,b,Aeq,beq,lb,ub,@(x)VolConstraint(x,Target,CovMat),options);
        
        %Rescaling Weights
        %SumWeights = 0; 
        
        %Loop adding the existing weights
        %for x = 1:asset
            %if WeightsOpti(position,x) ~= 0
              %  SumWeights = SumWeights + WeightsOpti(position,x);
            %end 
        %end 
       
        %Finding the weights in %
       %WeightsOpti(position,:) = WeightsOpti(position,:)/SumWeights;
         
        % Going for the next rebalancing 
        disp(position);
        position = position + 1;
       
    end
    
    disp('Optimisation is finished !')
end

