# EC-Benchmark-2-CSE370
This repository contains work done on the EC benchmark 2 announced at OMAE 2021. Specifically, this work concerns exercise 1, which is concerned with predicting exceedance probabilities and return values of extreme ocean waves from a provided 25 year data set. The included code is a modification of the MATLAB code provided in the original benchmark, and compares the results of different modeling approaches and extreme value distributions. The files provided in this repository are created by Jennings Ye with the help of [Taemin Heo](http://taeminheo.com) and [Dr. Lance Manuel](https://lancemanuel.netlify.app/) at The University of Texas at Austin.

## Modeling Approches
The original provided code from OMAE 2021 uses a annual maxima modeling approach with a gumbel distribution. In this work, a Peaks-over-Threshold (PoT) approach is investigated instead. The differences between the two modeling approaches with the same gumbel distribution is shown below. The threshold for PoT is set to the 99.9th percentile of the dataset to maintain a similar number of data points in the two methods. The plot shows the data points and 95% confidence interval of different exceedance probabilities for each model. Uncertainty estimation is done through bootstrapping 1000 trials.

![ModelingApproach](/plots/Annmax-PoT_Gumbel.png)

## Threshold Effects
The prediction results from PoT are affected by the threshold set in the model. The results of different thresholds of the 99th and 99.9th percentile are depicted below.

![Threshold Effects](/plots/ThresholdEffects_Gumbel.png)
