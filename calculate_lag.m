function lags = calculate_lag(C14_results,d18O_results,lag_interp)

% loop through cores
for i = 1:length(C14_results.summary)
    C14_depth = C14_results.summary(i).depth;
    C14_samples = C14_results.summary(i).age_samples;
    d18O_depth = d18O_results.summary(i).depth;
    d18O_samples = d18O_results.summary(i).age_samples;
    
    % combine depths
    depth_interp = unique(round([d18O_depth; C14_depth],5));
    
    % find depth range to calculate lag
    ind_min = find(depth_interp == max([d18O_depth(1) C14_depth(1)]));
    ind_max = find(depth_interp == min([d18O_depth(end) C14_depth(end)]));
    depth_interp = depth_interp(ind_min:ind_max);
    
    % interpolate age model samples to depths at which either data exists
    C14_sampinterp = interp1(C14_depth,C14_samples,depth_interp);
    d18O_sampinterp = interp1(d18O_depth,d18O_samples,depth_interp);
    
     
    lags(i).name = C14_results.summary(i).name;
    for j = 1:length(C14_sampinterp(1,:)) % loop through C14 samples
        % true age comes from each radiocarbon sample
        lags(i).lag(j).age = C14_sampinterp(:,j); 
        % produces lag 1000 samples
        lags(i).lag(j).samp = d18O_sampinterp-lags(i).lag(j).age; 
        % interpolate lags
        lags(i).lag(j).interp_samp = interp1(lags(i).lag(j).age,lags(i).lag(j).samp,lag_interp); 
    end

% combine all lags
lags(i).all_lag = [lags(i).lag(:).interp_samp];
lags(i).all_lag_upper = quantile(lags(i).all_lag,0.975,2);
lags(i).all_lag_lower = quantile(lags(i).all_lag,0.025,2);
lags(i).all_lag_median = nanmedian(lags(i).all_lag,2);
end


