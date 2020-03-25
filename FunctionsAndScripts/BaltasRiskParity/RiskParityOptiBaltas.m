function [WeightsOpti] = RiskParityOptiBaltas(Signal,Weights,Returns,Target,LengthSignal,LengthVol,LengthMonth)
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

%Disabling useless Warnings during optimisation
warning ( 'off' , 'MATLAB:nearlySingularMatrix')

% Setting options
options = optimoptions('fmincon','Display','off');

%Setting a position index allowing to move month by month on the matrix
position = 1; %Position Index

% *************************************
%Loop optimizing the weights for each month
%   Starting after a year (Initial Signal) 
%   Every 20 days (a month) - period of rebalancing
%   Until the end of the return.
% *************************************
disp('Optimisation is starting !')

    for i = LengthSignal+1:LengthMonth:(length(Returns)-LengthVol)
        
        if position == round(round((length(Returns)-LengthSignal)/LengthMonth,0)/10,0)
            disp('10% Done')
        elseif position == round(round((length(Returns)-LengthSignal)/LengthMonth,0)/3,0)
            disp('30% Done')
        elseif position == round(round((length(Returns)-LengthSignal)/LengthMonth,0)/2,0)
            disp('50% Done')
        elseif position == round(round((length(Returns)-LengthSignal)/LengthMonth,0)*3/4,0)
            disp('75% Done')
        else %do nothing
        end% Just print the position to know where we are withing the optimisation
        
        % Finding the available asset to perform logical indexing on the
        % optimization
        index = Weights(position,:)~=0;  % Vector of 1 if the initial weights is not equal to zero and 0 otherwise. 
                                         % So there is no need to perform
                                         % to check wheter the assets are
                                         % available from LengthSignal days from now
                                         % (Already done).
                                         
                                     
        % Setting the objective function (anonyme function)
        fun = @(x)sum(log(abs(x))); %Function going over the available assezs (index == 1)
        
        
        % No Bounds on the weights
        lb = [];
        ub = [];
        
        % No linear inequality constraint
        A = [];
        b = [];
        
        % No linear equality constraint
        Aeq = [];
        beq = [];
        
        % ********************************
        % Computing the vector that will go in the vol. constraint.
        
        %Pre-allocating a matrix of returns 
        WeightedReturns = zeros(LengthVol,1); 
        
        % Positions of the available assets 
        indexAvailable = find(index==1);
    
            for j = 1:round(LengthVol/LengthMonth,0) % Typically = 3 for vol 63, month 21
                for k = 1:sum(index)
                            WeightedReturns((j-1)*LengthMonth+1:(j-1)*...
                            LengthMonth+LengthMonth,k) ...
                            = Returns(i+(j-1)*LengthMonth:...
                             i+(j-1)*LengthMonth+LengthMonth-1,indexAvailable(k));
                end
            end
        
        % Optimizing the month's weights 
         WeightsOpti(position,index==1) = fmincon(@(x) fun(x), ...
             NetWeights(position,index==1),A,b,Aeq,beq,lb,ub,...
             @(x) VolConstraintBaltas(x,Target,i,Weights,Returns,LengthMonth,...
             LengthVol,position),options);
        
        %Rescaling Weights
        SumWeights = 0; 
        
        %Loop adding the existing weights
        for x = 1:asset
            if WeightsOpti(position,x) ~= 0
                SumWeights = SumWeights + WeightsOpti(position,x);
            end 
        end 
       
        %Finding the weights in %
        WeightsOpti(position,:) = WeightsOpti(position,:)/SumWeights;
         
        % Going for the next rebalancing 
        position = position + 1;
    end
    
    disp('Optimisation is finished !')
end


