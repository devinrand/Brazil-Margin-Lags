close all
clear all
clc

% calculate default lags in 1 kyr increments
d18O_default = load('Outputs\Brazil Margin_d18O_d18O\results.mat');
C14_default = load('Outputs\Brazil Margin_C14_C14\results.mat');
interp_lag = 10:1:18;
lags = calculate_lag(C14_default,d18O_default,interp_lag);

% calculate lag stacks 
[upper_stack] = calc_lag_stack(lags(2:4));
[lower_stack] = calc_lag_stack(lags(5:7));
[deep_stack] = calc_lag_stack(lags(8:10));
[abyss_stack] = calc_lag_stack(lags(11:12));

% calculate lag difference between lower intermediate and deep
[diff_uplow] = calc_lag_diff(upper_stack.samples, lower_stack.samples, interp_lag);
[diff_lowdeep] = calc_lag_diff(lower_stack.samples, deep_stack.samples, interp_lag);
[diff_deepabyss] = calc_lag_diff(deep_stack.samples, abyss_stack.samples, interp_lag);

% calcualte synthetic lags using d18O from Gebbie (2012)
d18O_gebbie = load('Outputs\Brazil Margin Gebbie_d18O\results.mat');
lags_gebbie = calculate_lag_gebbie(d18O_gebbie,interp_lag);




