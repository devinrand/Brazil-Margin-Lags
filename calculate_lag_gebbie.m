function lags = calculate_lag_gebbie(d18O_results,lag_interp)

for i = 1:length(d18O_results.summary)% loop through core
    d18O_depth = d18O_results.summary(i).depth;
    d18O_samples = d18O_results.summary(i).age_samples;  
    lags(i).name = d18O_results.summary(i).name;
    
    % true age is modeled age
    lags(i).age = d18O_depth*10; 
    % produces lag 1000 samples
    lags(i).lag_samp = d18O_samples-lags(i).age; 
    % interpolate lags
    lags(i).lag_samp_interp = interp1(lags(i).age,lags(i).lag_samp,lag_interp); 

    % calculate medians and quantiles
    lags(i).upper = quantile(lags(i).lag_samp,0.975,2);
    lags(i).lower = quantile(lags(i).lag_samp,0.025,2);
    lags(i).median = median(lags(i).lag_samp,2);

    % calculate medians and quantiles for interpolated lags
    lags(i).upper_interp = quantile(lags(i).lag_samp_interp,0.975,2);
    lags(i).lower_interp = quantile(lags(i).lag_samp_interp,0.025,2);
    lags(i).median_interp = median(lags(i).lag_samp_interp,2);
end


