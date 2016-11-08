theta = [-360:360]
figure
h1 = plot(theta,sind(theta))
hold on
h2 = plot(theta,cosd(theta))
grid on
legend([h1 h2],{'sin','cos'})