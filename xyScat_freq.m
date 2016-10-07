function [] = xyScat_freq(x,yl,yu)

for i = 1:length(x)
    hold on
    plot([x(i) x(i)],[yl(i) yu(i)],'k','linewidth',2)
end
