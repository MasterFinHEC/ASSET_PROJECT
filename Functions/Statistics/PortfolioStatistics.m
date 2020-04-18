function [Return,CumulativeReturn,Stat_table] = PortfolioStatistics(GeneralReturn,NetWeights,Leverage)

% Computing the returns of the strategy
[CumulativeReturn,Return] = StrategyReturn(Leverage,NetWeights,GeneralReturn);

% Computing the turnover
[AverageTurnover,~] = turnover(GeneralReturn,NetWeights);

% Computing the annualized mean
Mean = prod(Return+1)^(1/(length(Return)/12))-1;

% Computing the annualized volatility
Vol = std(Return)*sqrt(12);

% Computing the Sharpe Ratios
Sharpe = SharpeRatio(Return,0.01);

% Computing the Maximum DrawDown
MaxDrawDown = MDD(Return);

% Computing the Calmar Ratio
Calmar = Mean/MaxDrawDown;

% Computing the Kurtosis
Kurt = kurtosis(Return);

% Computing the Skewness
Skew = skewness(Return);

Stat_table = array2table([Mean;Vol;Kurt;Skew;AverageTurnover;...
    Sharpe;Calmar;MaxDrawDown],'RowNames',{'Annualized Mean','Annualized Volatility',...
    'Kurtosis','Skewness','Average Monthly Turnover %','Sharpe Ratio','Calmar Ratio'...
    'Maximum DrawDown'});

end

