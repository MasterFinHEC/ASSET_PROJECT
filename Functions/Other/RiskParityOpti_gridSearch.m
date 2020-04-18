function [WeightsOpti,MCRriskParity] = RiskParityOpti_gridSearch(Weights,Returns,Target,LengthSignal,LengthVol,LengthMonth,MonReturn,RiskFreeRate)
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
NetWeights = Weights; % Long/short weights of VolParity 

%Setting the size of the output. 
WeightsOpti = zeros(round((length(Returns)-LengthSignal)/LengthMonth,0),asset); %Size of the output 
MCRriskParity = zeros(round((length(Returns)-LengthSignal)/LengthMonth,0),asset);
Sharpe = zeros(121,1);
indices = zeros(121,2); 

%Setting the unused parameters of the optimisation (matlab obligates it)
A = []; %No linear constraint
b = []; %No linear constraint

%Disabling useless Warnings during optimisation
warning ( 'off' , 'MATLAB:nearlySingularMatrix')

%Setting a position index allowing to move month by month on the matrix
count = 1;
% *************************************
%Loop optimizing the weights for each month
%   Starting after a year (Initial Signal) 
%   Every 20 days (a month) - period of rebalancing
%   Until the end of the return.
% *************************************
disp('Optimisation is starting !')

for k = 1:0.20:3.0
    for l = 1:0.20:3.0
    position = 1;  
    WeightsOpti = zeros(round((length(Returns)-LengthSignal)/LengthMonth,0),asset); %Size of the output 
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
       %lb = ones(1,length(CovMat))*-1; 
       %ub = ones(1,length(CovMat));
 
        
        % Setting linear constraint
       %Aeq = ones(1,length(CovMat));
       %beq = 1;
       Aeq = [];
       beq = [];
        
        % Setting options
        options = optimoptions(@fmincon,'Algorithm','sqp',...
        'MaxIterations',1000000,'ConstraintTolerance',1.0000e-6, ...
        'OptimalityTolerance',1.0000e-6,'MaxFunctionEvaluations',...
        1000000,'display','none');
    
        %Setting the initial value
        InitialValue = NetWeights(position,index==1);
    
        for z = 1:length(InitialValue)
        
            if InitialValue(z) < 0
            InitialValue(z) = -k;
            else 
            InitialValue(z) = l;
            end
        end

        % Optimizing the month's weights 
        x = fmincon(fun,InitialValue,A,b,Aeq,beq,lb,ub,@(x)VolConstraint(x,Target,CovMat),options);
     
        % Attibuing the output
        WeightsOpti(position,index==1) = x;
        
        % Computing the risk Parity
        MCRriskParity(position,index==1) = (x'.*(CovMat*x')/(x*CovMat*x'))'.*100;
        
        % Going for the next rebalancing 
        position = position + 1;
       
    end
    
    %Pre-allocating for speed
    Return = zeros(length(WeightsOpti)-1,1);

    %Computing the returns
    for z = 1:length(WeightsOpti)-1
    Return(z) = WeightsOpti(z+1,:)*MonReturn(z,:)';
    end

    Sharpe(count) = (prod(Return+1)^(1/(length(Return)/12)) - 1 - RiskFreeRate)/(sqrt(12)*std(Return));
    disp(Sharpe(count))
    
    value = count/121*100;
    X = [num2str(value), ' % of optimisation performed' ];
    disp(X)
    indices(count,1) = k;
    indices(count,2) = l;
    count = count + 1;
   
    end   
end
disp('Grid Search Terminated')
disp('Finding maximal Sharpe ratio')

IdxMax = find(Sharpe == max(Sharpe));
disp(IdxMax)

if length(IdxMax) > 1
    IdxMax = IdxMax(1);
end

disp('Computing Weight of optimal Sharpe ratio')

position = 1;  

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
       %lb = ones(1,length(CovMat))*-1; 
       %ub = ones(1,length(CovMat));
 
        
        % Setting linear constraint
       %Aeq = ones(1,length(CovMat));
       %beq = 1;
       Aeq = [];
       beq = [];
        
        % Setting options
        options = optimoptions(@fmincon,'Algorithm','sqp',...
        'MaxIterations',1000000,'ConstraintTolerance',1.0000e-6, ...
        'OptimalityTolerance',1.0000e-6,'MaxFunctionEvaluations',...
        1000000,'display','none');
    
        %Setting the initial value
        InitialValue = NetWeights(position,index==1);
    
        for z = 1:length(InitialValue)
        
            if InitialValue(z) < 0
            InitialValue(z) = -indices(IdxMax,1);
            else 
            InitialValue(z) = indices(IdxMax,2);
            end
        end

        % Optimizing the month's weights 
        x = fmincon(fun,InitialValue,A,b,Aeq,beq,lb,ub,@(x)VolConstraint(x,Target,CovMat),options);
     
        % Attibuing the output
        WeightsOpti(position,index==1) = x;
        
        % Computing the risk Parity
        MCRriskParity(position,index==1) = (x'.*(CovMat*x')/(x*CovMat*x'))'.*100;
        
        % Going for the next rebalancing 
        position = position + 1;
       
    end
    
disp('Optimisation is finished !')
end

