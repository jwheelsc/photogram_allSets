clear variables

[dat, written] = xlsread('D:\Field_data\2013\Summer\Geotech\outcrop_disctontinuity.xlsx',1,'A1:AN102');
vars = written(:,1);
plotOn = logical(dat(strcmp(vars,'plot?'),:));

msLogi = dat(strcmp(vars,'rock type'),plotOn)== 1;
mxLogi = dat(strcmp(vars,'rock type'),plotOn)== 2;
stLogi = dat(strcmp(vars,'surge type'),plotOn)== 1;
ptLogi = dat(strcmp(vars,'rock type'),plotOn)== 3;
nstLogi = dat(strcmp(vars,'surge type'),plotOn)== 2;

glaciers = dat(strcmp(vars,'Glacier'),plotOn); 
labels = written(2,2:end);
labels = labels(plotOn)
maxFreq = dat(strcmp(vars,'max freq 40'),plotOn);
minFreq = dat(strcmp(vars,'min freq 40'),plotOn) ;
meanFreq = dat(strcmp(vars,'mean freq 40'),plotOn);
meanLgth = dat(strcmp(vars,'mean length'),plotOn);
stdLgth = dat(strcmp(vars,'std length'),plotOn);
numJnts = dat(strcmp(vars,'num joints'),plotOn);
totJntLength = dat(strcmp(vars,'total joint length'),plotOn);
numInts = dat(strcmp(vars,'intersections'),plotOn);
IntPA = dat(strcmp(vars,'intersectionsPerarea'),plotOn);
JntLgthPA = dat(strcmp(vars,'joint lengthPerarea'),plotOn);
JntsPA = dat(strcmp(vars,'jointsPerarea'),plotOn)
LX = dat(strcmp(vars,'length x (m)'),plotOn);
LY = dat(strcmp(vars,'length y (m)'),plotOn);
AR = dat(strcmp(vars,'area (m2)'),plotOn);
pxpm = dat(strcmp(vars,'scale factor (px/m)'),plotOn);
err = dat(strcmp(vars,'error m'),plotOn);
group_4 = dat(strcmp(vars,'group_4'),plotOn);
group_rk = dat(strcmp(vars,'group_rk'),plotOn);
l_d25 = dat(strcmp(vars,'l_d25'),plotOn);
l_d50 = dat(strcmp(vars,'l_d50'),plotOn);
l_d75 = dat(strcmp(vars,'l_d75'),plotOn);

%%% make some structure arrays

dataS = struct('glaciers',glaciers,'maxF',maxFreq,'minF',minFreq,'P10',meanFreq,'nJ',numJnts,...
    'tlJ',totJntLength,'nI',numInts,'I20',IntPA,'P21',JntLgthPA,'P20',JntsPA,'LX',LX,'LY',LY,...
    'AR',AR,'pxpm',pxpm,'err',err,'stdL',stdLgth,'mL',meanLgth,'ld25',l_d25,'ld50',l_d50,'ld75',l_d75)

dataM = [dataS.P21',dataS.P20',dataS.P10',dataS.I20',dataS.mL']

logiS = struct('ms',msLogi,'mx',mxLogi,'pt',ptLogi,'st',stLogi,'nst',nstLogi)

return


%% here's to make an xy plot

    
logOn = 0
legs = 1
x = dataS.mL
xlab = 'Mean length (m)'
y = dataS.stdL
ylab = 'Standard deviation in length (m)'

close all
f1 = figure(1) 

xyScat(x,y,dataS,logiS,labels,xlab,ylab,legs,logOn)
savePDFfunction(f1,'D:\Code\photog_allSets\figures\scatter_stdLvsmL')


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

logOn = 0
legs = 1

x = []
y = dataS.ld50
ylab = 'Median length (m)'

close all
f4 = figure(4) 

xlab = []
yScat(x,y,dataS,logiS,labels,xlab,ylab,legs,logOn)


savePDFfunction(f4,'D:\Code\photog_allSets\figures\group_medLgth')



%% plot results by group 4 plot

logOn = 0
legs = 1
x = [1:5]
xlab = 'group'
y = dataS.P21
ylab = 'P_{21} (m^{-1})'

close all
f4 = figure(4) 

for i = 1:5
    
    subplot(2,3,i)

    y = (dataM(:,i))

    plotLabs = {'P_{21} (m^{-1})','P_{20} (m^{-2})','P_{10} (m^{-1})','I_{20} (m^{-2})','mean length (m)'}
    
    xlab = []
    ylab = plotLabs{i}
    yScat(x,y,dataS,logiS,labels,xlab,ylab,legs,logOn)
    
end

savePDFfunction(f4,'D:\Code\photog_allSets\figures\group_5plot')

%% here you can do some statistics

%%% univariate tukey HSD

close all
[p,anovatab,stats] = anova1(dataS.mL,group_4)
[c,m,h,nms] = multcompare(stats,'ctype','hsd','alpha',0.1)
title('mean')

%% qq plot

dataM = (dataM)
corDat = corr(dataM)
covDat = cov(dataM)
n = length(dataM(:,1))
pvars = length(dataM(1,:))
mu = mean(dataM)
sinv = inv(covDat)

for i = 1:n
    
    a = dataM(i,:)-mu
    d(i) = a*sinv*a'

end

[ds,srt] = sort(d)
ps = ([1:n]-0.5)/n
qs = chi2inv(ps,pvars)

ylab = '$d_{(j)}^2$'
xlab = '$q_{c,16}((j-\frac{1}{2})/n)$'

logiS.ms = logiS.ms(srt)
logiS.mx = logiS.mx(srt)
logiS.st = logiS.st(srt)
logiS.nst = logiS.nst(srt)
logiS.pt = logiS.pt(srt)

close all
f5 = figure(5)
legs = 1
logOn = 0
xyScat(qs,ds,dataS,logiS,labels(srt),xlab,ylab,legs,logOn)
hold on
hline = refline(1,0)
hasbehavior(hline,'legend',false)

title('Chi-square plot on raw data','fontsize',18)

savePDFfunction(f5,'D:\Code\photog_allSets\figures\qqplot')













