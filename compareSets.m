clear variables

[dat, written] = xlsread('D:\Field_data\2013\Summer\Geotech\outcrop_disctontinuity.xlsx',1,'A1:AN113');
vars = written(:,1);
% plotOn = logical(dat(strcmp(vars,'plot all'),:));
plotOn = logical(dat(strcmp(vars,'plot ave'),:));
% plotOn = logical(dat(strcmp(vars,'plot ms only'),:));

msLogi = dat(strcmp(vars,'lithological class'),plotOn)== 1;
mxLogi = dat(strcmp(vars,'lithological class'),plotOn)== 2;
stLogi = dat(strcmp(vars,'surge type'),plotOn)== 1;
nstLogi = dat(strcmp(vars,'surge type'),plotOn)== 2;
ptLogi = dat(strcmp(vars,'rock type'),plotOn)== 2;
msRockLogi = dat(strcmp(vars,'rock type'),plotOn)== 1;
group_4 = dat(strcmp(vars,'group_4'),plotOn);

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
l_d25 = dat(strcmp(vars,'l_d25'),plotOn);
l_d50 = dat(strcmp(vars,'l_d50'),plotOn);
l_d75 = dat(strcmp(vars,'l_d75'),plotOn);
d1 = dat(strcmp(vars,'d1'),plotOn);
d2 = dat(strcmp(vars,'d2'),plotOn);
rmsd = dat(strcmp(vars,'rmsd'),plotOn);
beta = dat(strcmp(vars,'beta'),plotOn);

f1 = dat(strcmp(vars,'f1_v2'),plotOn);
d1_v2 = 1./f1
f2 = dat(strcmp(vars,'f2_v2'),plotOn);
d2_v2 = 1./f2
AR2 = dat(strcmp(vars,'aspect ratio_v2'),plotOn);
nrmsd = dat(strcmp(vars,'rmsd_v2'),plotOn);
beta2 = dat(strcmp(vars,'beta_v2'),plotOn);

%%% make some structure arrays

dataS = struct('glaciers',glaciers,'maxF',maxFreq,'minF',minFreq,'P10',meanFreq,'nJ',numJnts,...
    'tlJ',totJntLength,'nI',numInts,'I20',IntPA,'P21',JntLgthPA,'P20',JntsPA,'LX',LX,'LY',LY,...
    'AR',AR,'pxpm',pxpm,'err',err,'stdL',stdLgth,'mL',meanLgth,'ld25',l_d25,'ld50',l_d50,'ld75',l_d75)

dataM = [dataS.P21',dataS.P20',dataS.P10',dataS.I20',dataS.mL']

logiS = struct('ms',msLogi,'mx',mxLogi,'pt',ptLogi,'st',stLogi,'nst',nstLogi,'msR',msRockLogi)



%% here im just calculating the true aspect ratio from the data, this really shouldn't be in this part of the code, but so it goes. 

for i = 1:length(d1)
    if d2(i)<d1(i)
        d2p(i)=d1(i)
        d1p(i)=d2(i)
    else
        d2p(i)=d2(i)
        d1p(i) = d1(i)
    end
end
d1 = d1p
d2 = d2p
        
       
thetaM = atand(sind(beta)./((d2./d1)+cosd(beta)))

ARtop = sqrt(d1.^2 + d2.^2 + d1.*d2.*cosd(thetaM)).*cosd(thetaM)
ARbottom = d1.*sind(beta)

tAR_v1 = ARtop./ARbottom


d1 = d1_v2
d2 = d2_v2
beta = beta2        
       
thetaM = atand(sind(beta)./((d2./d1)+cosd(beta)))

ARtop = sqrt(d1.^2 + d2.^2 + d1.*d2.*cosd(thetaM)).*cosd(thetaM)
ARbottom = d1.*sind(beta)

tAR_v2 = ARtop./ARbottom



return
%% here's to make an xy plot

    
logOn = 0
legs = 1
x = log(tAR_v2)
xlab = 'log(aspect ratio)'
y = log(AR2)
% for i = 1:length(y)
%     if y(i)<1
%         y(i) = 1./y(i)
%     end
% end
% ylab = 'Modelled aspect ratio'
ylab = ''

close all
f1 = figure(1) 
subplot(1,2,2)
axis equal
xyScat(x,y,dataS,logiS,labels,xlab,ylab,legs,logOn)

load ARvsMaxoMin.mat
hold on
plot(log(tAR),log(AR),'b')
% rl = refline(1,0)
% rl.Color = [0 0 0]
ylim([0 1])
xlim([0 2])
% t1 = text(0.79,0.526,'\beta = 70^o','fontsize',16)
% t1.BackgroundColor = [1 1 1]
% t1 = text(0.78,0.615,'\beta = 80^o','fontsize',16)
% t1.BackgroundColor = [1 1 1]
% t1 = text(0.76,0.7,'\beta = 90^o','fontsize',16)
% t1.BackgroundColor = [1 1 1]
title('Method 2','fontsize',18)
text(0.1,-0.05,'b.','fontsize',22)
    
%%% and here you plot the results from the first method
x = log(tAR_v1)
xlab = 'log(aspect ratio)'
ylab = ''

legs = 0
subplot(1,2,1)
axis equal
xyScat(x,y,dataS,logiS,labels,xlab,ylab,legs,logOn)

load ARvsMaxoMin.mat
hold on
plot(log(tAR),log(AR),'b')
% rl = refline(1,0)
% rl.Color = [0 0 0]
ylim([0 1])
xlim([0 2])
xos1 = -0.1
t1 = text(0.79+xos1,0.526,'\beta = 70^o','fontsize',16)
t1.BackgroundColor = [1 1 1]
t1 = text(0.78+xos1,0.615,'\beta = 80^o','fontsize',16)
t1.BackgroundColor = [1 1 1]
t1 = text(0.76+xos1,0.7,'\beta = 90^o','fontsize',16)
t1.BackgroundColor = [1 1 1]
title('Method 1','fontsize',18)
text(0.1,-0.05,'b.','fontsize',22)
ylabel('log(ratio of set''s spacing)')

savePDFfunction(f1,'D:\Code\photog_allSets\figures\oct_26\True_aspect_ratio')


return

%% single scatter
    
logOn = 0
legs = 1
y = (maxFreq./minFreq)
ylab = 'RMMF'
x = (dataS.P20)
% for i = 1:length(y)
%     if y(i)<1
%         y(i) = 1./y(i)
%     end
% end
% ylab = 'Modelled aspect ratio'
xlab = 'P_{20} (m^{-2})'

close all
f1 = figure(1) 
axis equal
xyScat(x,y,dataS,logiS,labels,xlab,ylab,legs,logOn)
% refline(1,0)
savePDFfunction(f1,'D:\Code\photog_allSets\figures\nov_4\maxOminvsP21')

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

% yl = (dataS.ld25) 
% yu = (dataS.ld75) 
% x = (dataS.mL)
% y = (dataS.ld50)
x = (dataS.P21)
xlab = 'P_{21} (m^{-1})'
y = (dataS.P10)
ylab = 'P_{10} (m^{-1})'
hold on
xyScat_err(x,y,dataS.err)

% hold on
% xyScat_freq(x,yl,yu)
% 
% xlab = 'Mean length (m)'
% ylab = 'Length quantiles_{[0.25, 0.50, 0.75]} (m)'

hold on
xyScat(x,y,dataS,logiS,labels,xlab,ylab,legs,logOn)
% hold on
% plot(x,log(dataS.ld50),'ks','markersize',8,'markerfacecolor','k')
% rl = refline(1,0)
% rl.Color = [0 0 0]
% hasbehavior(rl,'legend',false)

savePDFfunction(f3,'D:\Documents\Presentations\NWG2016\scatter_P10vsP21_allErr')
return

%% plot results by group 

logOn = 0
legs = 1

x = []
y = (maxFreq./minFreq)./dataS.P21
% for i = 1:length(y)
%     if y(i)<1
%         y(i) = 1./y(i)
%     end
% end
ylab = 'd2/d1'

close all
f4 = figure(4) 
subplot(1,3,2)
title('Method 1','fontsize',16)
xlab = []
yScat(x,y,dataS,logiS,labels,xlab,ylab,legs,logOn)
ylim([0.8 2.8])


subplot(1,3,1)
logOn = 0
legs = 1

x = []
y = maxFreq./minFreq

ylab = 'max./min. frequency'
xlab = []
yScat(x,y,dataS,logiS,labels,xlab,ylab,legs,logOn)
ylim([0.8 2.8])

subplot(1,3,3)
logOn = 0
legs = 1

x = []
y = tAR_v2

ylab = 'aspect ratio'
xlab = []
yScat(x,y,dataS,logiS,labels,xlab,ylab,legs,logOn)
ylim([0.8 2.8])
savePDFfunction(f4,'D:\Code\photog_allSets\figures\nov_4\groupARandFreq2')



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

% savePDFfunction(f4,'D:\Code\photog_allSets\figures\group_5plot')

%% plot results by group, 1 plot, no stats

logOn = 0
legs = 1
x = [1:5]
ylab = 'RMMF / P_{20} (m^2)'
y = maxFreq./minFreq./dataS.P20
xlab = []
close all
f4 = figure(4) 
yScat(x,y,dataS,logiS,labels,xlab,ylab,legs,logOn)
   
savePDFfunction(f4,'D:\Code\photog_allSets\figures\nov_4\group_RMFFOP21')

%% plot results by group 


% ylim([0.8 2.8])

% savePDFfunction(f4,'D:\Code\photog_allSets\figures\oct_26\groupARandFreq2')

%%% here you can do some statistics
titles = {'P_{21} (m^{-1})','P_{20} (m^{-2})','P_{10} (m^{-1})','I_{20} (m^{-2})','Mean length (m)'}
titlesF = {'P21','P20','P10','I20','Mean length'}
% groups = [group_4;logiS.ms;logiS.st]
% groupStr = {'4 Groups','Basin lithology','Glacier type'}

% 
% dataM = [tAR_v2;maxFreq./minFreq;AR2]'
% titles = {'Aspect ratio','Max./min frequency','d2/d1'}
% titlesF = {'Aspect ratio','MaxOmin frequency','d2Od1'}
% groups = [group_4;logiS.ms;logiS.st;logiS.pt;group_mss]
groupStr = {'4 Groups','Basin lithology','Glacier type','Rocktype','metaseds lithology by glacier type'}


%%% univariate tukey HSD

% for j = 1:length(dataM(:,1))
for j = 1
    
%     x = []
%     y1 = dataM(:,j)'
%     ymss = y1(logical(logiS.ms.*logiS.st))
%     logiMSS = ones(1,length(ymss))
%     ymsns = y1(logical(logiS.ms.*logiS.nst))
%     y = [ymss,ymsns]
%     logiMSS = [logiMSS,ones(1,length(ymsns))*2]
%     ylab = titles{j}
    
    x = []
    y = maxFreq./minFreq./dataS.P20
%     ymss = y1(logical(logiS.ms.*logiS.st))
%     logiMSS = ones(1,length(ymss))
%     ymsns = y1(logical(logiS.ms.*logiS.nst))
%     y = [ymss,ymsns]
%     logiMSS = [logiMSS,ones(1,length(ymsns))*2]
    ylab = titles{j}
    
    legs = 0
    logOn = 0
    close all
    f4 = figure(4) 
    title('Method 1','fontsize',16)
    xlab = []
    yScat(x,y,dataS,logiS,labels,xlab,ylab,legs,logOn)
    set(gca,'fontsize',18)
%     savePDFfunction(f4,['D:\Code\photog_allSets\figures\nov_4\' titlesF{j}])
%     keyboard
    for i = 5
%         close all
        logOn = 0
        legs = 1
%         [p,anovatab,stats] = anova1(y,groups(i,:))
        [p,anovatab,stats] = anova1(y,logiS.st)
        [c,m,h,nms] = multcompare(stats,'ctype','hsd','alpha',0.1)
        title([titlesF{j} ' - ' groupStr{i}])
        f2 = figure(2)
%         savePDFfunction(f2,['D:\Code\photog_allSets\figures\nov_4\' titlesF{j} ' ' groupStr{i} 'ms only'])
%         keyboard

    end
end
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













