clear all
close all

% here you can get the point cloud from ptCloud, but for some reason,
% ptCloud won't read in the colors from the .ply file, so you actually have
% to read in the .ply file from textscan and convert the colors to uint8,
% then plot it. 

% load the pointcloud cloud from the vSFM model
ptCloud = pcread('D:\Code\photogrammetry\imageSequences\Glaciers\GL7\test3.nvm.cmvs\00\models\option-0000.ply');
% read in just the xyz coordinates and color from the same point clod
f1 = fopen('D:\Code\photogrammetry\imageSequences\Glaciers\GL7\test3.nvm.cmvs\00\models\option-0000_4ml.ply');
a1 = textscan(f1,'%f %f %f %f %f %f %d %d %d');
xyz = [a1{1} a1{2} a1{3}];
color = [a1{7} a1{8} a1{9}];
close all
% convert the color format and append it to ptCloud
fig1 = figure
ptCloud.Color = uint8(color);
pcshow(ptCloud)

%% make some bars here to compute a scale factor
% 
% figure 
% imshow('D:\Field_data\2013\Summer\Images\JWC\Aug01\GL8\Photogrammetry\GL8PG01ST1_6\IMG_1514.JPG')


%% here we are doing short range, and we know the absolute distance between
%%% camera stations to be X meters, and there is 1 camera per station. We
%%% don't care about orienting the model at this point, and we know the
%%% scale on the wall.

% read in the camera coordinates from the vSFM model
f2 = fopen('D:\Code\photogrammetry\imageSequences\Glaciers\GL7\test3.nvm.cmvs\00\centers-0000_4ml.ply');
a = textscan(f2,'%f %f %f');
p = [a{1} a{2} a{3}];

[ps,pi] = sort(p(:,1))
ps = p(pi,:)


% clust = kmeans(p(:,1),3)
% st1 = p(clust==1,:)
% st2 = p(clust==2,:)
% st3 = p(clust==3,:)

st1 = mean(ps([2 3],:))
st2 = mean(ps([4 6],:))

% stations = [st1;st2;st3]

% sts = [2 3 4 6]
for i = [2 3 4 6]
    hold on
    plot3(ps(i,1),ps(i,2),ps(i,3),'ro','markerfacecolor','b')
    text(ps(i,1),ps(i,2),ps(i,3),num2str(i))
end

hold on
plot3(st1(1),st1(2),st1(3),'ro','markerfacecolor','g')
text(st1(1),st1(2),st1(3),'st1')
hold on
plot3(st2(1),st2(2),st2(3),'ro','markerfacecolor','g')
text(st2(1),st2(2),st2(3),'st2')

% stDiff = stations(2:end,:)-stations(1:end-1,:)
% stDist = sqrt(stDiff(:,1).^2+stDiff(:,2).^2+stDiff(:,3).^2)

% mstd = mean(stDist)
% mtpxpm = mstd/6

cC = [607991 6750166 2383;608046 6750150 2369]

mC = [st1;st2]

cCd = sqrt(sum(diff(cC).^2))
mCd = sqrt(sum(diff(mC).^2))

mlpxpm = mCd/cCd

%% get the length length of 3 lines on 2D image


% s3 scale bars

p1 = [-0.8252 -0.7437 1.719]
p2 = [-0.8629 -0.8215 1.752]
p3 = [-0.879 -0.7537 1.728]
p4 = [-0.7811 -0.7598 1.71]
p5 = [-0.7465 -0.7107 1.715]
scPts = [p1;p2;p3;p4;p5]

hold on
plot3(p1(1),p1(2),p1(3),'ro','markerfacecolor','y')
text(p1(1),p1(2),p1(3),num2str(1), 'fontsize',14,'color','r')
hold on
plot3(p2(1),p2(2),p2(3),'ro','markerfacecolor','y')
text(p2(1),p2(2),p2(3),num2str(2), 'fontsize',14,'color','r')
hold on
plot3(p3(1),p3(2),p3(3),'ro','markerfacecolor','y')
text(p3(1),p3(2),p3(3),num2str(3), 'fontsize',14,'color','r')
hold on
plot3(p4(1),p4(2),p4(3),'ro','markerfacecolor','y')
text(p4(1),p4(2),p4(3),num2str(4), 'fontsize',14,'color','r')
hold on
plot3(p5(1),p5(2),p5(3),'ro','markerfacecolor','y')
text(p5(1),p5(2),p5(3),num2str(5), 'fontsize',14,'color','r')

count = 1
dist3d = []
for i = 1:length(scPts)-1
    for j = i+1:length(scPts)
        dist3d(count) = sqrt(sum((scPts(i,:)-scPts(j,:)).^2))
        count = count+1 
    end
end
dist3d = dist3d/mlpxpm
save('D:\Field_data\2013\Summer\Images\JWC\Aug01\GL7\Photogrammetry\GL7PG1ST2\IMG_1348_analysis\scales3d.mat','dist3d')
f1 = gcf
savePDFfunction(f1,'D:\Field_data\2013\Summer\Images\JWC\Aug01\GL7\Photogrammetry\GL7PG1ST2\IMG_1348_analysis\model3d')

return

hold on
plot3(ps(:,1),ps(:,2),ps(:,3),'bo','markerfacecolor','b')
hold on
% txt = [1:5]
% for i = 1:5
%     text(ps(i,1),ps(i,2),ps(i,3),num2str(txt(i))) 
% end
for i = 1:(length(bars(:,1)))/2
    hold on
    plot3(bars((2*i)-1:2*i,1),bars((2*i)-1:2*i,2),bars((2*i)-1:2*i,3),'y-','linewidth',10)
end
% view([0 280])
% savePDFfunction(fig1,'D:\Documents\Writing\Thesis\photogram\figures\fracture_mapping_methods_v1\scales3d')


len_m = ps(2:end,:)-ps(1:end-1,:)
d_m = sqrt(sum(len_m.*len_m,2))
d_m = d_m(d_m<1.5)

d = 6

sf = d/mean(d_m)
sfp = d/(mean(d_m)+std(d_m))
sfm = d/(mean(d_m)-std(d_m))

lines_3d = lin3d*sf

msf = lines_2d./lines_3d
ppm = mean(msf) % pixels per meter
return
fs = figure
h = plot(lines_2d,lines_3d,'o')
h.MarkerFaceColor = h.Color
xlim([0 10])
ylim([0 10])
refline(1,0)
grid on

xlabel('Trace length in 2D (from scale ball)','fontsize',16)
ylabel('Trace length in 3D (from camera spacing)','fontsize',16)
set(gca,'fontsize',16)
savePDFfunction(fs,'D:\Documents\Writing\Thesis\photogram\figures\fracture_mapping_methods_v1\scales2Dvs3D')
% 

































