% load saved figures
fig1   = hgload('AnnmaxGumbel.fig');
fig2   = hgload('AnnmaxGEV.fig');
%fig3   = hgload('AnnmaxWeibull.fig');
%  Prepare 'subplot'
figure
h1=subplot(1,1,1);
h2=subplot(1,1,1);
%h3=subplot(1,1,1);
line1=copyobj(allchild(get(fig1,'CurrentAxes')),h1);
set(line1, 'color', 'blue');
hold on
line2=copyobj(allchild(get(fig2,'CurrentAxes')),h1);
set(line2, 'color', 'r');
%line3=copyobj(allchild(get(fig3,'CurrentAxes')),h1);
%set(line3, 'color', 'g');
xlabel('Annual Maxima Hs [m]')
ylabel('Exceedance probability')
set(gca,'yscale','log')
set(gca,'YMinorTick','off')
set(gca,'YMinorGrid','off')
set(gca,'YTick',[1e-2 2e-2 1e-1 2e-1 1])
set(gca,'YTickLabel',{'1/100','1/50','1/10','1/5','1'})
title(['GEV and Gumbel'])
legend('Gumbel', '','','','GEV')