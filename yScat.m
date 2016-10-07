function [] = yScat(x,y,dataS,logiS,labels,xlab,ylab,legs,logOn)

ms = 10;
fs = 12;
tfs = fs-4
txtOn = 0

lg1 = logical(logiS.st.*logiS.ms)
y1 = y(lg1)
h1 = plot(ones(1,length(y1))*1,y1,...
    'o','markerfacecolor',[1 0 0],'markersize',ms,'markeredgecolor','k')
    txt = labels(lg1)
    if txtOn == 1
        for i = 1:sum(lg1)
            text(1.1,y1(i),txt(i),'fontsize',tfs)
        end
    end

hold on
lg2 = logical(logiS.st.*logiS.mx)
y2 = y(lg2)
h2 = plot(ones(1,length(y2))*2,y2,...
    '^','markerfacecolor',[1 0 0],'markersize',ms,'markeredgecolor','k')
    txt = labels(lg2)
    if txtOn == 1
        for i = 1:sum(lg2)
            text(2.1,y2(i),txt(i),'fontsize',tfs)
        end
    end

hold on
lg3 = logical(logiS.nst.*logiS.ms)
y3 = y(lg3)
h3 = plot(ones(1,length(y3))*3,y3,...
    'o','markerfacecolor',[0.6 0.6 0.6],'markersize',ms,'markeredgecolor','k')
    txt = labels(lg3)
    if txtOn == 1
        for i = 1:sum(lg3)
            text(3.1,y3(i),txt(i),'fontsize',tfs)
        end
    end


hold on
lg4 = logical(logiS.nst.*logiS.mx)
y4 = y(lg4)
h4 = plot(ones(1,length(y4))*4,y4,...
    '^','markerfacecolor',[0.6 0.6 0.6],'markersize',ms,'markeredgecolor','k')
    txt = labels(lg4)
    if txtOn == 1
        for i = 1:sum(lg4)
            text(4.1,y4(i),txt(i),'fontsize',tfs)
        end
    end

hold on
lg5 = logical(logiS.st.*logiS.pt)
y5 = y(lg5)
h5 = plot(ones(1,length(y5))*2,y5,...
    's','markerfacecolor',[1 0 0],'markersize',ms,'markeredgecolor','k')
    txt = labels(lg5)
    if txtOn == 1
        for i = 1:sum(lg5)
            text(2.1,y5(i),txt(i),'fontsize',tfs)
        end
    end


hold on
lg6 = logical(logiS.nst.*logiS.pt)
y6 = y(lg6)
h6 = plot(ones(1,length(y6))*4,y6,...
    's','markerfacecolor',[0.6 0.6 0.6],'markersize',ms,'markeredgecolor','k')
    txt = labels(lg6)
    if txtOn == 1
        for i = 1:sum(lg6)
            text(4.1,y6(i),txt(i),'fontsize',tfs)
        end
    end


xlim([0 5])
% ylim([0 45])
grid on
set(gca,'xtick',[0:1:5],'xticklabel',{'','MS-S','MX-S','MS-NS','MX-NS', ''},'fontsize',fs)

if logOn == 1
%     xlabel(['log (' xlab ')'])
    ylabel(['log (' ylab ')'])
else
%     xlabel(xlab)
    ylabel(ylab)
end