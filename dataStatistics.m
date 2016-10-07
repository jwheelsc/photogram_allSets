run loadData.m

return
%% here you can do some statistics

%%% univariate tukey HSD

close all
[p,anovatab,stats] = anova1(dataS.mL,group_4)
[c,m,h,nms] = multcompare(stats,'ctype','hsd','alpha',0.1)
title('mean')

%% qq plot

dat = log(dataM)
corDat = corr(dat)
covDat = cov(dat)
n = length(dat(:,1))
pvars = length(dat(1,:))
mu = mean(dat)
sinv = inv(covDat)

for i = 1:n
    
    a = dat(i,:)-mu
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
logOn = 1
xyScat(qs,ds,dataS,logiS,labels(srt),xlab,ylab,legs,logOn)
hold on
hline = refline(1,0)
hasbehavior(hline,'legend',false)

title('Chi-square plot on log transformed data','fontsize',18)

savePDFfunction(f5,'D:\Code\photog_allSets\figures\qqplot_log')

%% Behrens-Fisher problem, or something similar.

pop_st = dataM(logiS.st,:)
pop_ns = dataM(logiS.nst,:)

S_st = generalizedVariance(pop_st)
SI_st = inv(S_st)
S_ns = generalizedVariance(pop_ns)
SI_ns = inv(S_ns)

%% estimating the covariance structure
run loadData.m

close all
fs = 12
% dat = (dataM-mean(dataM))./dataM
% coDat = corr(dataM)

% coDat = cov(dataM)
% dat = (dataM-mean(dataM))./[diag(coDat)]'
% coDat = cov(dat)

% dat = log(dataM)
% coDat = corr(dat)

% dat = (dataM-mean(dataM))./std(dataM)
dat = dataM
coDat = cov(dat)

[ve,va] = eig(coDat)

Sr = dat*ve
Sr = -Sr(:,[end:-1:1]);

ve = ve(:,[end:-1:1]);
ve = -ve;

va = sum(va);
va = va([end:-1:1]);

tv = trace(coDat);
pv = (va/tv)*100;

close all
f2 = figure(2)
bar(pv)
xlim([0 6])
grid on
set(gca,'xtick',[0:1:6],'xticklabel',{'','PC1','PC2','PC3','PC4', 'PC5'})
ylabel('Percent variance')
set(gca,'fontsize',fs)
savePDFfunction(f2,'D:\Code\photog_allSets\figures\pcaPV')


f1 = figure(1)
legs = 0
logOn = 0
xlab = 'PC1'
ylab = 'PC1'
xlab = []
% y = score(:,1)
y = Sr(:,1)
x = []
yScat(x,y,dataS,logiS,labels,xlab,ylab,legs,logOn)
savePDFfunction(f1,'D:\Code\photog_allSets\figures\pcaPC1')

f4 = figure(4)
bar(ve(:,1))

set(gca,'xtick',[1:5],'xticklabel',plotLabs,'fontsize',12)
ylabel('Loading onto PC1','fontsize',12)
savePDFfunction(f4,'D:\Code\photog_allSets\figures\pcaLoad')

%% estimating the covariance structure from factor analysis
run loadData.m

% dat = (dataM-mean(dataM))./std(dataM)
dat = dataM

coDat = corr(dat)
[ve,va] = eig(coDat)

m = 2
dsva = [diag(sqrt(va))]

L = ve(:,1:m).*dsva(1:m)'
% L = rotatefactors(L)

close all
f1 = figure(1)
plot(L(:,1),L(:,2),'o','markerfacecolor','b')
xl = get(gca,'xlim')
% xl(2) = 0
for i =1:length(dataM(1,:))
    text(L(i,1)+((1/2000)*xl(2)),L(i,2),plotLabs_noU(i))
end
grid on

xlabel('Loading 1')
ylabel('Loading 2')
set(gca,'fontsize',20)
savePDFfunction(f1,'D:\Code\photog_allSets\figures\factor_Loading_noL')


f = inv(L'*L)*L'*(dat-mean(dat))'
logOn = 0
legs = 0
x = f(1,:)
xlab = 'Factor 1 scores'
y = f(2,:)
ylab = 'Factor 2 scores'

f2 = figure(2) 
xyScat(x,y,dataS,logiS,labels,xlab,ylab,legs,logOn)
savePDFfunction(f2,'D:\Code\photog_allSets\figures\factor_scores_noL')


return









































