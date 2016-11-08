function [] = xyScat(x,y,dataS,logiS,labels,xlab,ylab,legs,logOn)

ms = 12;
fs = 22;

h1 = plot(x(logical(logiS.st.*logiS.ms)),y(logical(logiS.st.*logiS.ms)),...
    'o','markerfacecolor',[1 0 0],'markersize',ms,'markeredgecolor','k')
hold on
h2 = plot(x(logical(logiS.st.*logiS.mx.*logiS.msR)),y(logical(logiS.st.*logiS.mx.*logiS.msR)),...
    '^','markerfacecolor',[1 0 0],'markersize',ms,'markeredgecolor','k')
hold on
h3 = plot(x(logical(logiS.nst.*logiS.ms)),y(logical(logiS.nst.*logiS.ms)),...
    'o','markerfacecolor',[0.6 0.6 0.6],'markersize',ms,'markeredgecolor','k')
hold on
h4 = plot(x(logical(logiS.nst.*logiS.mx.*logiS.msR)),y(logical(logiS.nst.*logiS.mx.*logiS.msR)),...
    '^','markerfacecolor',[0.6 0.6 0.6],'markersize',ms,'markeredgecolor','k')
hold on
h5 = plot(x(logical(logiS.st.*logiS.pt)),y(logical(logiS.st.*logiS.pt)),...
    's','markerfacecolor',[1 0 0],'markersize',ms,'markeredgecolor','k')
hold on
h6 = plot(x(logical(logiS.nst.*logiS.pt)),y(logical(logiS.nst.*logiS.pt)),...
    's','markerfacecolor',[0.6 0.6 0.6],'markersize',ms,'markeredgecolor','k')


% h1 = plot(x(logical(logiS.st.*logiS.ms)),y(logical(logiS.st.*logiS.ms)),...
%     's','markerfacecolor',[200 160 90]/255,'markersize',ms,'markeredgecolor','k')
% hold on
% h2 = plot(x(logical(logiS.st.*logiS.mx)),y(logical(logiS.st.*logiS.mx)),...
%     's','markerfacecolor',[200 160 90]/255,'markersize',ms,'markeredgecolor','k')
% hold on
% h3 = plot(x(logical(logiS.nst.*logiS.ms)),y(logical(logiS.nst.*logiS.ms)),...
%     's','markerfacecolor',[200 160 90]/255,'markersize',ms,'markeredgecolor','k')
% hold on
% h4 = plot(x(logical(logiS.nst.*logiS.mx)),y(logical(logiS.nst.*logiS.mx)),...
%     's','markerfacecolor',[200 160 90]/255,'markersize',ms,'markeredgecolor','k')
hold on
% h5 = plot(x(logical(logiS.st.*logiS.pt)),y(logical(logiS.st.*logiS.pt)),...
%     's','markerfacecolor',[255 0 255]/255,'markersize',ms,'markeredgecolor','k')
% hold on
% h6 = plot(x(logical(logiS.nst.*logiS.pt)),y(logical(logiS.nst.*logiS.pt)),...
%     's','markerfacecolor',[255 0 255]/255,'markersize',ms,'markeredgecolor','k')

xls = get(gca,'xlim')
dxls = (xls(2)-xls(1))/100
for i = 1:length(labels)
    text(x(i)+dxls,y(i),labels{i}, 'fontsize',8)
end

set(gca,'fontsize',fs)

grid on

if logOn == 1
    xlabel(['log (' xlab ')'])
    ylabel(['log (' ylab ')'])
%     xlabel(['log (' xlab ')'],'interpreter','latex')
%     ylabel(['log (' ylab ')'],'interpreter','latex')
else
%     xlabel(xlab,'interpreter','latex')
%     ylabel(ylab,'interpreter','latex')
    xlabel(xlab)
    ylabel(ylab)
end

if legs == 1
    
    l1 = legend([h1 h2  h5 h3 h4 h6],{'Surge-metased.','Surge-mixed_{ms}','Surge-mixed_{gd}','Normal-metased',...
        'Normal-mixed_{ms}','Normal-mixed_{gd}'},'fontsize',16,'location','southeast')
%     l1 = legend([h1 h5],{'metsedimentary', 'granodiorite'},'fontsize',fs-4,'location','southeast')
%     l1 = legend([h1 h2 h3 h4],{'Surge-metased.','Surge-mixed_{ms}','Normal-metased',...
%         'Normal-mixed_{ms}'},'fontsize',fs-4,'location','southeast')

    
end

% xlim([0 45])