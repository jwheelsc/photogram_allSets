function [] = err(x,y,err)

lw = 1

%% plot the errors in y

absEy = err.*y
absEx = err.*x

for i = 1:length(x)
    hold on
    plot([x(i) x(i)],[y(i)+absEy(i) y(i)-absEy(i)],'k','linewidth',lw)
end

xls = get(gca,'xlim')
dxls = (xls(2)-xls(1))/80

for i = 1:length(x)
    hold on
    plot([x(i)+dxls x(i)-dxls],[y(i)+absEy(i) y(i)+absEy(i)],'k','linewidth',lw)
end

for i = 1:length(x)
    hold on
    plot([x(i)+dxls x(i)-dxls],[y(i)-absEy(i) y(i)-absEy(i)],'k','linewidth',lw)
end

%% plot the errors in x


xls = get(gca,'ylim')
dyls = (xls(2)-xls(1))/80

for i = 1:length(x)
    hold on
    plot([x(i)-absEx(i) x(i)+absEx(i)],[y(i) y(i)],'k','linewidth',lw)
end

for i = 1:length(x)
    hold on
    plot([x(i)-absEx(i) x(i)-absEx(i)],[y(i)+dyls y(i)-dyls],'k','linewidth',lw)
end

for i = 1:length(x)
    hold on
    plot([x(i)+absEx(i) x(i)+absEx(i)],[y(i)+dyls y(i)-dyls],'k','linewidth',lw)
end
