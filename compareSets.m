clear variables

[dat, written] = xlsread('D:\Field_data\2013\Summer\Geotech\outcrop_disctontinuity.xlsx',1,'A1:AJ43');
vars = written(:,1);
msLogi = dat(strcmp(vars,'rock type'),:)== 1;
mxLogi = dat(strcmp(vars,'rock type'),:)== 2;
stLogi = dat(strcmp(vars,'surge type'),:)== 1;
nstLogi = dat(strcmp(vars,'surge type'),:)== 2;

glaciers = dat(strcmp(vars,'Glacier'),:); 
labels = written(2,2:end); 
maxFreq = dat(strcmp(vars,'max freq'),:);
minFreq = dat(strcmp(vars,'min freq'),:) ;
meanFreq = dat(strcmp(vars,'mean freq'),:);
numJnts = dat(strcmp(vars,'num joints'),:);
totJntLength = dat(strcmp(vars,'total joint length'),:);
numInts = dat(strcmp(vars,'intersections'),:);
IntPA = dat(strcmp(vars,'intersectionsPerarea'),:);
JntLgthPA = dat(strcmp(vars,'joint lengthPerarea'),:);
JntsPA = dat(strcmp(vars,'jointsPerarea'),:)
LX = dat(strcmp(vars,'length x (m)'),:);
LY = dat(strcmp(vars,'length y (m)'),:);
AR = dat(strcmp(vars,'area (m2)'),:);
pxpm = dat(strcmp(vars,'scale factor (px/m)'),:);

ftNAN = (isnan(maxFreq)==0)

%%


msLogi = msLogi(ftNAN)
mxLogi = mxLogi(ftNAN)
stLogi = stLogi(ftNAN)
nstLogi = nstLogi(ftNAN)

close all
f1 = figure(1)


GLnum = glaciers(ftNAN)
labs = labels(ftNAN)

x = JntLgthPA(ftNAN)
y = meanFreq(ftNAN)
plot(x(logical(stLogi.*msLogi)),y(logical(stLogi.*msLogi)),...
    'o','markerfacecolor',[1 0 0],'markersize',10,'markeredgecolor','k')
hold on
plot(x(logical(stLogi.*mxLogi)),y(logical(stLogi.*mxLogi)),...
    '^','markerfacecolor',[1 0 0],'markersize',10,'markeredgecolor','k')
hold on
plot(x(logical(nstLogi.*msLogi)),y(logical(nstLogi.*msLogi)),...
    'o','markerfacecolor',[0.6 0.6 0.6],'markersize',10,'markeredgecolor','k')
hold on
plot(x(logical(nstLogi.*mxLogi)),y(logical(nstLogi.*mxLogi)),...
    '^','markerfacecolor',[0.6 0.6 0.6],'markersize',10,'markeredgecolor','k')



xls = get(gca,'xlim')
dxls = (xls(2)-xls(1))/80
for i = 1:length(GLnum)
    text(x(i)+dxls,y(i),labs{i}, 'fontsize',10)
end

% for i = 1:length(freqX)
%     hold on 
%     plot([freqX(i)-dxls, freqX(i)+dxls], [freqL(i) freqL(i)], 'k', 'linewidth', 2)
% end
    
grid on
xlabel('P_{21}')
ylabel('P_{10}')
% xlim([0 22])
% set(gca,'xtick',[0:22])
set(gca,'fontsize',18)
% savePDFfunction(f1,'D:\Code\photog_allSets\figures\njVsArea')
return
%% six subplots

close all
f1 = figure(1)
fs = 12
ms = 6

ftNAN = (isnan(maxFreq)==0)

GLnum = glaciers(ftNAN)
labs = labels(ftNAN)


subplot(3,2,1)
x = JntLgthPA(ftNAN)
y = meanFreq(ftNAN)
h1 = plot(x(logical(stLogi.*msLogi)),y(logical(stLogi.*msLogi)),...
    'o','markerfacecolor',[1 0 0],'markersize',10,'markeredgecolor','k')
hold on
h2 = plot(x(logical(stLogi.*mxLogi)),y(logical(stLogi.*mxLogi)),...
    '^','markerfacecolor',[1 0 0],'markersize',10,'markeredgecolor','k')
hold on
h3 = plot(x(logical(nstLogi.*msLogi)),y(logical(nstLogi.*msLogi)),...
    'o','markerfacecolor',[0.6 0.6 0.6],'markersize',10,'markeredgecolor','k')
hold on
h4 = plot(x(logical(nstLogi.*mxLogi)),y(logical(nstLogi.*mxLogi)),...
    '^','markerfacecolor',[0.6 0.6 0.6],'markersize',10,'markeredgecolor','k')


l1 = legend([h1 h2 h3 h4],{'MSS','MXS','MSNS','MXNS'},'location','southeast')

xls = get(gca,'xlim')
dxls = (xls(2)-xls(1))/80
for i = 1:length(GLnum)
    text(x(i)+dxls,y(i),labs{i}, 'fontsize',10)
end
grid on
xlabel('P_{21} (m^{-1})')
ylabel('frequency (m^{-1})')
set(gca,'fontsize',fs)




subplot(3,2,2)
x = JntsPA(ftNAN)
y = JntLgthPA(ftNAN)
plot(x(logical(stLogi.*msLogi)),y(logical(stLogi.*msLogi)),...
    'o','markerfacecolor',[1 0 0],'markersize',10,'markeredgecolor','k')
hold on
plot(x(logical(stLogi.*mxLogi)),y(logical(stLogi.*mxLogi)),...
    '^','markerfacecolor',[1 0 0],'markersize',10,'markeredgecolor','k')
hold on
plot(x(logical(nstLogi.*msLogi)),y(logical(nstLogi.*msLogi)),...
    'o','markerfacecolor',[0.6 0.6 0.6],'markersize',10,'markeredgecolor','k')
hold on
plot(x(logical(nstLogi.*mxLogi)),y(logical(nstLogi.*mxLogi)),...
    '^','markerfacecolor',[0.6 0.6 0.6],'markersize',10,'markeredgecolor','k')

xls = get(gca,'xlim')
dxls = (xls(2)-xls(1))/80
for i = 1:length(GLnum)
    text(x(i)+dxls,y(i),labs{i}, 'fontsize',10)
end
grid on
xlabel('P_{20} (m^{-2})')
ylabel('P_{21} (m^{-1})')
set(gca,'fontsize',fs)


subplot(3,2,3)
x = JntsPA(ftNAN)
y = meanFreq(ftNAN)
plot(x(logical(stLogi.*msLogi)),y(logical(stLogi.*msLogi)),...
    'o','markerfacecolor',[1 0 0],'markersize',10,'markeredgecolor','k')
hold on
plot(x(logical(stLogi.*mxLogi)),y(logical(stLogi.*mxLogi)),...
    '^','markerfacecolor',[1 0 0],'markersize',10,'markeredgecolor','k')
hold on
plot(x(logical(nstLogi.*msLogi)),y(logical(nstLogi.*msLogi)),...
    'o','markerfacecolor',[0.6 0.6 0.6],'markersize',10,'markeredgecolor','k')
hold on
plot(x(logical(nstLogi.*mxLogi)),y(logical(nstLogi.*mxLogi)),...
    '^','markerfacecolor',[0.6 0.6 0.6],'markersize',10,'markeredgecolor','k')

xls = get(gca,'xlim')
dxls = (xls(2)-xls(1))/80
for i = 1:length(GLnum)
    text(x(i)+dxls,y(i),labs{i}, 'fontsize',10)
end
grid on
xlabel('P_{20} (m^{-2})')
ylabel('frequency (m^{-1})')
set(gca,'fontsize',fs)


subplot(3,2,4)
x = JntLgthPA(ftNAN)
y = IntPA(ftNAN)
plot(x(logical(stLogi.*msLogi)),y(logical(stLogi.*msLogi)),...
    'o','markerfacecolor',[1 0 0],'markersize',10,'markeredgecolor','k')
hold on
plot(x(logical(stLogi.*mxLogi)),y(logical(stLogi.*mxLogi)),...
    '^','markerfacecolor',[1 0 0],'markersize',10,'markeredgecolor','k')
hold on
plot(x(logical(nstLogi.*msLogi)),y(logical(nstLogi.*msLogi)),...
    'o','markerfacecolor',[0.6 0.6 0.6],'markersize',10,'markeredgecolor','k')
hold on
plot(x(logical(nstLogi.*mxLogi)),y(logical(nstLogi.*mxLogi)),...
    '^','markerfacecolor',[0.6 0.6 0.6],'markersize',10,'markeredgecolor','k')

xls = get(gca,'xlim')
dxls = (xls(2)-xls(1))/80
for i = 1:length(GLnum)
    text(x(i)+dxls,y(i),labs{i}, 'fontsize',10)
end
grid on
xlabel('P_{21} (m^{-1})')
ylabel('int/A (m^{-2})')
set(gca,'fontsize',fs)

subplot(3,2,5)
x = IntPA(ftNAN)
y = meanFreq(ftNAN)
plot(x(logical(stLogi.*msLogi)),y(logical(stLogi.*msLogi)),...
    'o','markerfacecolor',[1 0 0],'markersize',10,'markeredgecolor','k')
hold on
plot(x(logical(stLogi.*mxLogi)),y(logical(stLogi.*mxLogi)),...
    '^','markerfacecolor',[1 0 0],'markersize',10,'markeredgecolor','k')
hold on
plot(x(logical(nstLogi.*msLogi)),y(logical(nstLogi.*msLogi)),...
    'o','markerfacecolor',[0.6 0.6 0.6],'markersize',10,'markeredgecolor','k')
hold on
plot(x(logical(nstLogi.*mxLogi)),y(logical(nstLogi.*mxLogi)),...
    '^','markerfacecolor',[0.6 0.6 0.6],'markersize',10,'markeredgecolor','k')

xls = get(gca,'xlim')
dxls = (xls(2)-xls(1))/80
for i = 1:length(GLnum)
    text(x(i)+dxls,y(i),labs{i}, 'fontsize',10)
end
grid on
xlabel('int/A (m^{-2})')
ylabel('frequency (m^{-1})')
set(gca,'fontsize',fs)


subplot(3,2,6)
x = IntPA(ftNAN)
y = JntsPA(ftNAN)
plot(x(logical(stLogi.*msLogi)),y(logical(stLogi.*msLogi)),...
    'o','markerfacecolor',[1 0 0],'markersize',10,'markeredgecolor','k')
hold on
plot(x(logical(stLogi.*mxLogi)),y(logical(stLogi.*mxLogi)),...
    '^','markerfacecolor',[1 0 0],'markersize',10,'markeredgecolor','k')
hold on
plot(x(logical(nstLogi.*msLogi)),y(logical(nstLogi.*msLogi)),...
    'o','markerfacecolor',[0.6 0.6 0.6],'markersize',10,'markeredgecolor','k')
hold on
plot(x(logical(nstLogi.*mxLogi)),y(logical(nstLogi.*mxLogi)),...
    '^','markerfacecolor',[0.6 0.6 0.6],'markersize',10,'markeredgecolor','k')

xls = get(gca,'xlim')
dxls = (xls(2)-xls(1))/80
for i = 1:length(GLnum)
    text(x(i)+dxls,y(i),labs{i}, 'fontsize',10)
end
grid on
xlabel('int/A (m^{-2})')
ylabel('P_{20} (m^{-2})')
set(gca,'fontsize',fs)

savePDFfunction(f1,'D:\Code\photog_allSets\figures\sixPlot')

%% six subplots in log space

close all
f1 = figure(1)
fs = 10
ms = 6

ftNAN = (isnan(maxFreq)==0)

GLnum = glaciers(ftNAN)
labs = labels(ftNAN)


subplot(3,2,1)
x = log(JntLgthPA(ftNAN))
y = log(meanFreq(ftNAN))
h1 = plot(x(logical(stLogi.*msLogi)),y(logical(stLogi.*msLogi)),...
    'o','markerfacecolor',[1 0 0],'markersize',10,'markeredgecolor','k')
hold on
h2 = plot(x(logical(stLogi.*mxLogi)),y(logical(stLogi.*mxLogi)),...
    '^','markerfacecolor',[1 0 0],'markersize',10,'markeredgecolor','k')
hold on
h3 = plot(x(logical(nstLogi.*msLogi)),y(logical(nstLogi.*msLogi)),...
    'o','markerfacecolor',[0.6 0.6 0.6],'markersize',10,'markeredgecolor','k')
hold on
h4 = plot(x(logical(nstLogi.*mxLogi)),y(logical(nstLogi.*mxLogi)),...
    '^','markerfacecolor',[0.6 0.6 0.6],'markersize',10,'markeredgecolor','k')

l1 = legend([h1 h2 h3 h4],{'MSS','MXS','MSNS','MXNS'},'location','southeast')

xls = get(gca,'xlim')
dxls = (xls(2)-xls(1))/80
for i = 1:length(GLnum)
    text(x(i)+dxls,y(i),labs{i}, 'fontsize',10)
end
grid on
xlabel('log(P_{21} (m^{-1}))')
ylabel('log(frequency (m^{-1}))')
set(gca,'fontsize',fs)


subplot(3,2,2)
x = log(JntsPA(ftNAN))
y = log(JntLgthPA(ftNAN))
h1 = plot(x(logical(stLogi.*msLogi)),y(logical(stLogi.*msLogi)),...
    'o','markerfacecolor',[1 0 0],'markersize',10,'markeredgecolor','k')
hold on
h2 = plot(x(logical(stLogi.*mxLogi)),y(logical(stLogi.*mxLogi)),...
    '^','markerfacecolor',[1 0 0],'markersize',10,'markeredgecolor','k')
hold on
h3 = plot(x(logical(nstLogi.*msLogi)),y(logical(nstLogi.*msLogi)),...
    'o','markerfacecolor',[0.6 0.6 0.6],'markersize',10,'markeredgecolor','k')
hold on
h4 = plot(x(logical(nstLogi.*mxLogi)),y(logical(nstLogi.*mxLogi)),...
    '^','markerfacecolor',[0.6 0.6 0.6],'markersize',10,'markeredgecolor','k')

xls = get(gca,'xlim')
dxls = (xls(2)-xls(1))/80
for i = 1:length(GLnum)
    text(x(i)+dxls,y(i),labs{i}, 'fontsize',10)
end
grid on
xlabel('log(P_{20} (m^{-2}))')
ylabel('log(P_{21} (m^{-1}))')
set(gca,'fontsize',fs)


subplot(3,2,3)
x = log(JntsPA(ftNAN))
y = log(meanFreq(ftNAN))
h1 = plot(x(logical(stLogi.*msLogi)),y(logical(stLogi.*msLogi)),...
    'o','markerfacecolor',[1 0 0],'markersize',10,'markeredgecolor','k')
hold on
h2 = plot(x(logical(stLogi.*mxLogi)),y(logical(stLogi.*mxLogi)),...
    '^','markerfacecolor',[1 0 0],'markersize',10,'markeredgecolor','k')
hold on
h3 = plot(x(logical(nstLogi.*msLogi)),y(logical(nstLogi.*msLogi)),...
    'o','markerfacecolor',[0.6 0.6 0.6],'markersize',10,'markeredgecolor','k')
hold on
h4 = plot(x(logical(nstLogi.*mxLogi)),y(logical(nstLogi.*mxLogi)),...
    '^','markerfacecolor',[0.6 0.6 0.6],'markersize',10,'markeredgecolor','k')

xls = get(gca,'xlim')
dxls = (xls(2)-xls(1))/80
for i = 1:length(GLnum)
    text(x(i)+dxls,y(i),labs{i}, 'fontsize',10)
end
grid on
xlabel('log(P_{20} (m^{-2}))')
ylabel('log(frequency (m^{-1}))')
set(gca,'fontsize',fs)


subplot(3,2,4)
x = log(JntLgthPA(ftNAN))
y = log(IntPA(ftNAN))
h1 = plot(x(logical(stLogi.*msLogi)),y(logical(stLogi.*msLogi)),...
    'o','markerfacecolor',[1 0 0],'markersize',10,'markeredgecolor','k')
hold on
h2 = plot(x(logical(stLogi.*mxLogi)),y(logical(stLogi.*mxLogi)),...
    '^','markerfacecolor',[1 0 0],'markersize',10,'markeredgecolor','k')
hold on
h3 = plot(x(logical(nstLogi.*msLogi)),y(logical(nstLogi.*msLogi)),...
    'o','markerfacecolor',[0.6 0.6 0.6],'markersize',10,'markeredgecolor','k')
hold on
h4 = plot(x(logical(nstLogi.*mxLogi)),y(logical(nstLogi.*mxLogi)),...
    '^','markerfacecolor',[0.6 0.6 0.6],'markersize',10,'markeredgecolor','k')

xls = get(gca,'xlim')
dxls = (xls(2)-xls(1))/80
for i = 1:length(GLnum)
    text(x(i)+dxls,y(i),labs{i}, 'fontsize',10)
end
grid on
xlabel('log(P_{21} (m^{-1}))')
ylabel('log(int/A (m^{-2}))')
set(gca,'fontsize',fs)

subplot(3,2,5)
x = log(IntPA(ftNAN))
y = log(meanFreq(ftNAN))
h1 = plot(x(logical(stLogi.*msLogi)),y(logical(stLogi.*msLogi)),...
    'o','markerfacecolor',[1 0 0],'markersize',10,'markeredgecolor','k')
hold on
h2 = plot(x(logical(stLogi.*mxLogi)),y(logical(stLogi.*mxLogi)),...
    '^','markerfacecolor',[1 0 0],'markersize',10,'markeredgecolor','k')
hold on
h3 = plot(x(logical(nstLogi.*msLogi)),y(logical(nstLogi.*msLogi)),...
    'o','markerfacecolor',[0.6 0.6 0.6],'markersize',10,'markeredgecolor','k')
hold on
h4 = plot(x(logical(nstLogi.*mxLogi)),y(logical(nstLogi.*mxLogi)),...
    '^','markerfacecolor',[0.6 0.6 0.6],'markersize',10,'markeredgecolor','k')

xls = get(gca,'xlim')
dxls = (xls(2)-xls(1))/80
for i = 1:length(GLnum)
    text(x(i)+dxls,y(i),labs{i}, 'fontsize',10)
end
grid on
xlabel('log(int/A (m^{-2}))')
ylabel('log(frequency (m^{-1}))')
set(gca,'fontsize',fs)


subplot(3,2,6)
x = log(IntPA(ftNAN))
y = log(JntsPA(ftNAN))
h1 = plot(x(logical(stLogi.*msLogi)),y(logical(stLogi.*msLogi)),...
    'o','markerfacecolor',[1 0 0],'markersize',10,'markeredgecolor','k')
hold on
h2 = plot(x(logical(stLogi.*mxLogi)),y(logical(stLogi.*mxLogi)),...
    '^','markerfacecolor',[1 0 0],'markersize',10,'markeredgecolor','k')
hold on
h3 = plot(x(logical(nstLogi.*msLogi)),y(logical(nstLogi.*msLogi)),...
    'o','markerfacecolor',[0.6 0.6 0.6],'markersize',10,'markeredgecolor','k')
hold on
h4 = plot(x(logical(nstLogi.*mxLogi)),y(logical(nstLogi.*mxLogi)),...
    '^','markerfacecolor',[0.6 0.6 0.6],'markersize',10,'markeredgecolor','k')

xls = get(gca,'xlim')
dxls = (xls(2)-xls(1))/80
for i = 1:length(GLnum)
    text(x(i)+dxls,y(i),labs{i}, 'fontsize',10)
end
grid on
xlabel('log(int/A (m^{-2}))')
ylabel('log(P_{20} (m^{-2}))')
set(gca,'fontsize',fs)

savePDFfunction(f1,'D:\Code\photog_allSets\figures\log_sixPlot')



%% plot the min max frequency bars
close all
f1 = figure(2)
ftNAN = (isnan(maxFreq)==0)

GLnum = glaciers(ftNAN)
labs = labels(ftNAN)

x = JntLgthPA(ftNAN)
y = meanFreq(ftNAN)
yu = maxFreq(ftNAN)
yl = minFreq(ftNAN)
freqL = [yu,yl]
freqX = [x,x]




xls = get(gca,'xlim')
dxls = (xls(2)-xls(1))/80
for i = 1:length(GLnum)
%     text(x(i)+dxls,y(i),labs{i}, 'fontsize',16)
    hold on 
    plot([x(i), x(i)], [yu(i) yl(i)], 'k', 'linewidth', 2)
end

for i = 1:length(freqX)
    hold on 
    plot([freqX(i)-dxls, freqX(i)+dxls], [freqL(i) freqL(i)], 'k', 'linewidth', 2)
end
    
hold on
h1 = plot(x(logical(stLogi.*msLogi)),y(logical(stLogi.*msLogi)),...
    'o','markerfacecolor',[1 0 0],'markersize',10,'markeredgecolor','k')
hold on
h2 = plot(x(logical(stLogi.*mxLogi)),y(logical(stLogi.*mxLogi)),...
    '^','markerfacecolor',[1 0 0],'markersize',10,'markeredgecolor','k')
hold on
h3 = plot(x(logical(nstLogi.*msLogi)),y(logical(nstLogi.*msLogi)),...
    'o','markerfacecolor',[0.6 0.6 0.6],'markersize',10,'markeredgecolor','k')
hold on
h4 = plot(x(logical(nstLogi.*mxLogi)),y(logical(nstLogi.*mxLogi)),...
    '^','markerfacecolor',[0.6 0.6 0.6],'markersize',10,'markeredgecolor','k')


grid on
xlabel('P_{21}')
ylabel('P_{10} (m^{-1})')
% xlim([0 22])
% set(gca,'xtick',[0:22])
set(gca,'fontsize',18)
savePDFfunction(f1,'D:\Code\photog_allSets\figures\p21Vsfreq')


%% here's some more nasty mess where you might decide to do some PCA
% 
% glaciers = dat(strcmp(vars,'Glacier'),:); 
% labels = written(2,2:end); 
% maxFreq = dat(strcmp(vars,'max freq'),:);
% minFreq = dat(strcmp(vars,'min freq'),:) ;
% meanFreq = dat(strcmp(vars,'mean freq'),:);
% numJnts = dat(strcmp(vars,'num joints'),:);
% totJntLength = dat(strcmp(vars,'total joint length'),:);
% numInts = dat(strcmp(vars,'intersections'),:);
% IntPA = dat(strcmp(vars,'intersectionsPerarea'),:);
% JntLgthPA = dat(strcmp(vars,'joint lengthPerarea'),:);
% JntsPA = dat(strcmp(vars,'jointsPerarea'),:)
% LX = dat(strcmp(vars,'length x (m)'),:);
% LY = dat(strcmp(vars,'length y (m)'),:);
% AR = dat(strcmp(vars,'area (m2)'),:);
% pxpm = dat(strcmp(vars,'scale factor (px/m)'),:);

maxFreq = [maxFreq(ftNAN)]'
minFreq = [minFreq(ftNAN)]'
meanFreq = [meanFreq(ftNAN)]'
JntLgthPA = [JntLgthPA(ftNAN)]'
JntsPA = [JntsPA(ftNAN)]'

X = [maxFreq,minFreq,meanFreq,JntLgthPA,JntsPA]

princomp(X')






