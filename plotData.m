run loadData.m

%% here's to make an xy plot

    
logOn = 0
legs = 0
y = dataS.P10
ylab = 'P_{10} (m^{-1})'
x = dataS.P21
xlab = 'P_{21} (m^{-1})'

close all
f1 = figure(1) 

xyScat(x,y,dataS,logiS,labels,xlab,ylab,legs,logOn)
xlim([0 45])
savePDFfunction(f1,'D:\Code\photog_allSets\figures\scatter_P10vsP21_byMSrock')


return
%% here's to make subplot scatter

logOn = 0
legs = 0

close all
f1 = figure(1) 

plotLabs = {'P_{21} (m^{-1})','P_{20} (m^{-2})','P_{10} (m^{-1})','I_{20} (m^{-2})'}

count = 1
for i = 1:3
    for j = i+1:4
        subplot(3,2,count)
        if i == 1 && j == 2
            legs = 1
        else 
            legs = 0
        end
        x = (dataM(:,i))
        y = (dataM(:,j))
        xyScat(x,y,dataS,logiS,labels,plotLabs{i},plotLabs{j},legs,logOn)
        count = count+1
    end
end

savePDFfunction(f1,'D:\Code\photog_allSets\figures\scatter_6plot')


return
%% plot the min max frequency bars
close all
logOn = 0
legs = 1
f3 = figure(3)

yl = (dataS.ld25) 
yu = (dataS.ld75) 
x = (dataS.mL)
y = (dataS.ld50)
hold on
% xyScat_err(x,y,dataS.err)

% hold on
xyScat_freq(x,yl,yu)

xlab = 'Mean length (m)'
ylab = 'Length quantiles_{[0.25, 0.50, 0.75]} (m)'

hold on
xyScat(x,y,dataS,logiS,labels,xlab,ylab,legs,logOn)
% hold on
% plot(x,log(dataS.ld50),'ks','markersize',8,'markerfacecolor','k')
rl = refline(1,0)
rl.Color = [0 0 0]
hasbehavior(rl,'legend',false)

savePDFfunction(f3,'D:\Code\photog_allSets\figures\scatter_quantilesvsMean')
return

%% plot results by group 

logOn = 1
legs = 1

x = []
y = log(dataS.P21)
ylab = 'Median length (m)'

close all
f4 = figure(4) 

xlab = []
yScat(x,y,dataS,logiS,labels,xlab,ylab,legs,logOn)


% savePDFfunction(f4,'D:\Code\photog_allSets\figures\group_medLgth')



%% plot results by group 4 plot

logOn = 1
legs = 1
x = [1:5]
xlab = 'group'
y = dataS.P21
ylab = 'P_{21} (m^{-1})'

close all
f4 = figure(4) 

for i = 1:4
    
    subplot(2,2,i)

    y = (log(dataM(:,i)))

    plotLabs = {'P_{21} (m^{-1})','P_{20} (m^{-2})','P_{10} (m^{-1})','I_{20} (m^{-2})','mean length (m)'}
    
    xlab = []
    ylab = plotLabs{i}
    yScat(x,y,dataS,logiS,labels,xlab,ylab,legs,logOn)
    
end

savePDFfunction(f4,'D:\Code\photog_allSets\figures\group_4plot_log')















