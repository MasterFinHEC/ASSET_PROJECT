%% Extension : Risk Parity - Turnover Constraint

disp('Computing the turnover constrained risk parity allocation.')
% Setting Up turnover Target
TargetTurnover = 1;

%We have net Weights
BpFees = [0.01, 0.03];
TargetCost = 0.05;
LevCost = zeros(364,1);
for i = 1:364
    Fees = FeesComputation(BpFees,NetWeightsRiskParity(i+2:i+3,:));
    LevCost(i) = TargetCost/Fees(2);
end

% Risk Parity
[ReturnTFRPLSC,CumReturnTFRPLSC,StatsTFRPLSC] = PortfolioStatistics(MonReturn,NetWeightsRiskParity,LevCost);
[SharpeTFRPLSC,~,~] = CorrelationEvent(LengthSignal,LengthMonth,InterCorrAll,ReturnTFRPLSC,RiskFreeRate);
% Computing the Weights Allocation
%[NetWeightsRiskParityConstrained,MCRRiskParityConstrained] = RiskParityOpti_TurnoverConstraint(Signal,NetWeightsRiskParity,...
   % returns,targetVol,LengthSignal,LengthVol,LengthMonth,MonReturn,TargetTurnover);


%Computing the leverage of the strategy
%LevRiskParityConstrained = Leverage(returns,LengthSignal,LengthMonth,LengthVol,NetWeightsRiskParityConstrained,targetVol);

% Risk Parity
%[ReturnTFRPLSC,CumReturnTFRPLSC,StatsTFRPLSC] = PortfolioStatistics(MonReturn,NetWeightsRiskParityConstrained,LevRiskParityConstrained);

% Low rebalancing
NetWeightsRebalanced = NetWeightsRiskParity;
for i = 4:length(NetWeightsRiskParity)-1
    if sum(ismember(i,4:2:length(NetWeightsRiskParity)-1)) ~= 0
    NetWeightsRebalanced(i,:) = NetWeightsRiskParity(i,:);
    else 
    NetWeightsRebalanced(i,:) = NetWeightsRiskParity(i-1,:);  
    end
end

%Computing the leverage of the strategy
LevRiskParityRebalanced = Leverage(returns,LengthSignal,LengthMonth,LengthVol,NetWeightsRebalanced,targetVol);

% Volatility Parity Long Short
[ReturnTFRPLSRebalanced,CumReturnTFRPLSRebalanced,StatsTFRPLSRebalanced] = PortfolioStatistics(MonReturn,NetWeightsRebalanced,LevRiskParityRebalanced);
[SharpeTFRPLSRebalanced,~,~] = CorrelationEvent(LengthSignal,LengthMonth,InterCorrAll,ReturnTFVPLS,RiskFreeRate);
