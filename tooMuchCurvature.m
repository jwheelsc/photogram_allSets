% function [lineOut] = tooMuchCurvature(points)
clear all
close all
figure
h = imfreehand
lin = h.getPosition


x = lin(:,1)
y = lin(:,2)

subplot(2,1,1)
plot(x,y,'o-')

t = 45*pi/180

R = [cos(t) -sin(t); sin(t) cos(t)]
linR = (R*lin')'

xR = linR(:,1)
yR = linR(:,2)

subplot(2,1,1)
hold on
plot(xR,yR,'o-')

axis equal


m = (y(2:end)-y(1:end-1))./(x(2:end)-x(1:end-1))
xm = x(1:end-1)+((x(2:end)-x(1:end-1))/2)

subplot(2,1,2)
plot(1:length(m),m,'o-')

mr = (yR(2:end)-yR(1:end-1))./(xR(2:end)-xR(1:end-1))
xmr = xR(1:end-1)+((xR(2:end)-xR(1:end-1))/2)

subplot(2,1,2)
hold on
plot(1:length(m),mr,'ro-')
ylim([-10 10])