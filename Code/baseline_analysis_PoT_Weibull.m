clear

% select case
exercise=1;
site=1;

% load data
filename=['Exercise' num2str(exercise) '_Site' num2str(site) '_FIOESM_data.csv'];
data=dlmread(filename,',',1,0);
year=data(:,1);
month=data(:,2);
Hs=data(:,5);

% create subset with PoT
thprc=99.9;
threshold=prctile(Hs, thprc);
pks=findpeaks(Hs);
%pks=findpeaks(Hs,'MinPeakProminence',range(Hs)*.50);
%pks=findpeaks(Hs,'MinPeakDistance',720);
indices=find(pks>threshold);
peaks=pks(indices);

% fit weibull distribution
parmhat=wblfit(peaks);
a=parmhat(1);
b=parmhat(2);

% calculate quantiles
N=logspace(0,3,length(peaks));
P=1-1./N;
x=wblinv(P,a,b);

% calculate return values
T=[5 50 500];
RV=wblinv(1-1./T,a,b);

% bootstrap record to get confidence interval
trials=1000;
x_boot=zeros(trials,length(P));
RV_boot=zeros(trials,3);
for j=1:trials
    z=resample(peaks);
    parmhat=wblfit(z);
    a=parmhat(1);
    b=parmhat(2);
    x_boot(j,:)=wblinv(P,a,b);
    RV_boot(j,:)=wblinv(1-1./T,a,b);
end
x_boot=sort(x_boot);
RV_boot=sort(RV_boot);

% write return value outputs
if exercise==1
    filename=['Ex' num2str(exercise) '_Site' num2str(site) '_ReturnValues_Baseline.csv'];
    header='Return Period [years],Return Value [m],CI 2.5%% [m],CI 97.5%% [m]\n';
elseif exercise==2
    filename=['Ex' num2str(exercise) '_Site' num2str(site) '_Quantiles_Baseline.csv'];
    header='Exceedance Prob,Quantile [m],CI 2.5%% [m],CI 97.5%% [m]\n';
end
fid=fopen(filename,'w');
fprintf(fid,header);
fclose(fid);
RVlow=RV_boot(round(trials*0.025),:);
RVhigh=RV_boot(round(trials*0.975),:);
dlmwrite(filename,[T(:) RV(:) RVlow(:) RVhigh(:)],'-append');

% write distribution outputs
if exercise==1
    filename=['Ex' num2str(exercise) '_Site' num2str(site) '_AnnualDist_Baseline.csv'];
elseif exercise==2
    filename=['Ex' num2str(exercise) '_Site' num2str(site) '_F25Dist_Baseline.csv'];
end
header='Exceedance Prob,Quantile [m],CI 2.5%% [m],CI 97.5%% [m]\n';
fid=fopen(filename,'w');
fprintf(fid,header);
fclose(fid);
xlow=x_boot(round(trials*0.025),:);
xhigh=x_boot(round(trials*0.975),:);
dlmwrite(filename,[1-P(:) x(:) xlow(:) xhigh(:)],'-append');

% calculate empirical exceedance probabilities
n=length(peaks);
k=1:n;
Pempirical=k/(n+1);

% plot results
fig=figure;
hold on; box on; grid on
plot(sort(peaks),1-Pempirical,'ko')
plot(x,1-P,'r')
plot(xlow,1-P,'b--')
plot(xhigh,1-P,'b--')
xlabel('Peaks over Threshold Hs [m]')
ylabel('Exceedance probability')
title(['PoT' char(8211) 'Threshold = ' num2str(thprc) '%, Weibull'])
annotation('textbox','String',append('n = ', num2str(n)),'FitBoxToText','on');
ylim([1e-2 1])
set(gca,'yscale','log')
set(gca,'YMinorTick','off')
set(gca,'YMinorGrid','off')
set(gca,'YTick',[1e-2 2e-2 1e-1 2e-1 1])
set(gca,'YTickLabel',{'1/100','1/50','1/10','1/5','1'})
saveas(fig, 'WblDistance720Threshold999.fig')
