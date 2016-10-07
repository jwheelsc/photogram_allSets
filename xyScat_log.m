function [] = xyScat_log(x,y,dataS,logiS,labels,xlab,ylab,legs)

ms = 8;
fs = 8;

plot(log(x(logical(logiS.st.*logiS.ms))),log(y(logical(logiS.st.*logiS.ms))),...
    'o','markerfacecolor',[1 0 0],'markersize',ms,'markeredgecolor','k')
hold on
plot(log(x(logical(logiS.st.*logiS.mx))),log(y(logical(logiS.st.*logiS.mx))),...
    '^','markerfacecolor',[1 0 0],'markersize',ms,'markeredgecolor','k')
hold on
plot(log(x(logical(logiS.nst.*logiS.ms))),log(y(logical(logiS.nst.*logiS.ms))),...
    'o','markerfacecolor',[0.6 0.6 0.6],'markersize',ms,'markeredgecolor','k')
hold on
plot(log(x(logical(logiS.nst.*logiS.mx))),log(y(logical(logiS.nst.*logiS.mx))),...
    '^','markerfacecolor',[0.6 0.6 0.6],'markersize',ms,'markeredgecolor','k')
hold on
plot(log(x(logical(logiS.st.*logiS.pt))),log(y(logical(logiS.st.*logiS.pt))),...
    's','markerfacecolor',[1 0 0],'markersize',ms,'markeredgecolor','k')
hold on
plot(log(x(logical(logiS.nst.*logiS.pt))),log(y(logical(logiS.nst.*logiS.pt))),...
    's','markerfacecolor',[0.6 0.6 0.6],'markersize',ms,'markeredgecolor','k')

xls = get(gca,'xlim')
dxls = (xls(2)-xls(1))/80
% for i = 1:length(labels)
%     text(x(i)+dxls,y(i),labels{i}, 'fontsize',fs)
% end

set(gca,'fontsize',10)

grid on
xlabel(['log_{10} (' xlab ')'])
ylabel(['log_{10} (' ylab ')'])