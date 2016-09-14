clear variables
close all

A = 1;

fArr = [0.1:0.1:5];
fArr = 1
theta = [0:1:90]*(pi/180);
for fi = 1:length(fArr)

    f = fArr(fi);
%     L_ave(fi,:) = f*A./(f*cos(theta)+sin(theta))
    L_ave(fi,:) = f*A./(sin(theta).*(f*cot(theta)+1));
    
end

plot(theta*180/pi,L_ave)
return
%%
close all
X = meshgrid(theta);
% size(X)
Y = meshgrid(fArr);
% size(Y)
% L_ave
% size(L_ave)
surf(theta*(180/pi),fArr,L_ave)




% theta = [90:0.05:180]*(pi/180)
% L_ave = -A./(cos(theta)-sin(theta))
% 
% hold on
% plot(theta*(180/pi),1./L_ave)
