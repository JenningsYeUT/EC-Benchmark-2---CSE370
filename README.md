# EC-Benchmark-2-CSE370
This repository contains work done on the EC benchmark 2 announced at OMAE 2021. Specifically, this work concerns exercise 1, which is concerned with predicting exceedance probabilities and return values of extreme ocean waves from a provided 25 year data set. The included code is a modification of the MATLAB code provided in the original benchmark, and compares the results of different modeling approaches and extreme value distributions. The files provided in this repository are created by Jennings Ye with the help of [Taemin Heo](http://taeminheo.com) and [Dr. Lance Manuel](https://lancemanuel.netlify.app/) at The University of Texas at Austin.

## Modeling Approches
The original provided code from OMAE 2021 uses a annual maxima modeling approach with a gumbel distribution. In this work, a Peaks-over-Threshold (PoT) approach is investigated instead. The differences between the two modeling approaches with the same gumbel distribution is shown below. The threshold for PoT is set to the 99.9th percentile of the dataset to maintain a similar number of data points in the two methods. The plot shows the data points and 95% confidence interval of different exceedance probabilities for each model. Uncertainty estimation is done through bootstrapping 1000 trials.

![ModelingApproach](/plots/Annmax-PoT_Gumbel.png)

## Threshold Effects
The prediction results from PoT are affected by the threshold set in the model. The results of different thresholds of the 99th and 99.9th percentile are depicted below. For comparison purposes, the thresholds were rather arbitrarily picked. Several ideas for proper threshold selection can be found in other work.

![ThresholdEffects](/plots/ThresholdEffects_Gumbel.png)

## Filtering/Declustering
In addition to different thresholds, the data in PoT can be filtered for declustering. This is primarily done through a run parameter, or the minimum number of data points between two peaks. The plots above default to a run parameter of 1. Additionally, declustering can be done through the peak prominence measure in MATLAB. This is a measure of the peak height relative to surrounding peaks. The plots below show both filtering methods, with a run parameter of 720, or about 3 months in the dataset, and a peak prominence of 50% of the range of wave heights. As with the thresholds, these values are rather arbitrarily selected for demonstration and comparison.

![DistanceFiltering](/plots/DistanceFiltering_Gumbel.png) 
![ProminenceFiltering](/plots/ProminenceFiltering_Gumbel.png)

## Distribution Effects
Different extreme value distributions were also compared. In particular, the results for the original annual maxima model approach for both the Weibull and Generalized Extreme Value (GEV) distributions are plotted together with the Gumbel distribution results below. Note that the Gumbel distribution fit uses a method of moments, while the Weibull and GEV distributions are fitted using maximum likelihood through built-in MATLAB functions. Note the model dataset is the same for all distributions as all use the annual maxima method.

![Weibull](/plots/WeibullGumbelAnnmax.png) 
![GEV](/plots/GEVGumbelAnnmax.png)


## Key Takeaways
The modeling parameters are important to the accurate prediction of extreme values. Different thresholds within the PoT method, as well as different declustering methods produce greatly different confidence intervals for these predictions. These parameters are all independent of the dataset, and should be chosen carefully. External scholarly work has been done on all of these parameters, and may be of interest for future work in creating more accurate predictive models.

## References
Guidelines and datasets, as well as the original provided code for this problem can be found at the original [ec-benchmark-2 repository](https://github.com/ec-benchmark-organizers/ec-benchmark-2). All results shown here are for the Site 1 data provided in the problem, and models have not been compared for the other test sites.
