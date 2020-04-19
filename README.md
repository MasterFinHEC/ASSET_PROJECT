# ASSET_PROJECT
Quantitative and Asset Management Project
- Msc. Science in Finance - HEC Lausanne
- Prof. Eric Jondeau

![Hec Lausanne Logo](https://upload.wikimedia.org/wikipedia/commons/7/77/Logo_HEC_Lausanne.png)

## Project
The goal of this project is to replicate and improve the following paper : 

["Trend-Following, Risk-Parity and the Influence of Correlations"](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=2673124) . Nick Baltas 2015. 

This paper is implementing mainly two strategies : 

- Trend-Following strategy with a volatility parity weighting scheme.
- Trend-Following strategy with a risk partiy weighting scheme.

The main observation is that the risk parity weighting scheme allows the strategy to be more robust in high correlation regime between asset class and to be even more un-correlated with the market, and therefore, be market neutral. 

## Implementation
On this repository, you'll find one principal code "Main3.m" that launch every other script and function, you just need to change the local path of the code and load "Kevin Sheperd ToolBox" at the beginning of the code, as follow:

```
addpath(genpath('Your_directory_where_you_will_use_the_code'))

addpath(genpath('Your_local_path_for_KevinSheperdToolBox'))
```

The following strategy are implemented : 

- Trend-Following Volatility Parity.
- Long-Only Volatility Parity. 
- Trend-Following Risk Parity. 
- Long Only Risk Parity. 

For each strategy the following statistics are computed : 

- Mean annualized returns
- Annualized Volatility
- Sharpe Ratio
- Calmar Ratio
- Maximum Drawdown
- Mean monthly turnover 
- Kurtosis
- Skewness

Then for every strategy, returns and statistics have been compute also with fees using two different regime for industry and individuals. 

### Code Structure
As said previously, the code 'Main3.' is calling every function and will run entire code. All the functions are in folder "Functions" and the sub-folders inside it. 

The output of the code will be generate inside the "Output" folders and the sub-folers inside it.

### Data
There is the data, we have used the create the project in the repository. However, the code should work for every dataset of continuous futures contract and even standard prices. The only part of the code that is not interchangeable are the graph generate by asset class. Thus, if you change the data, you would need to change a bit of code. 

Our data is a dataset of 35 futures prices that belongs to five asset classes. The sample is starting in 1989 and ending in 2020, however not all data are available at the beginning and the data is full only in 2016. 

## Acknowledgment 
 
- Prof. Eric Jondeau and Alexandre Pauli for the help provided throughout this project.
