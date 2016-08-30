
clear all
close all

% load('D:\Field_data\2013\Summer\Images\JWC\Aug07\GL18\Photogrammetry\GL18PG1ST2\IMG_250_analysis\scales2d.mat')

[folder, subFolder, imgNum, setIn, imSave, msfc, ws, ol] = whatFolder(15)
folderStr = [folder subFolder setIn]

f1 = figure('units','normalized','outerposition',[0 0 1 1])
imshow([folder imgNum])

   

%%

l1 = ginput(1)
keyboard
l2 = ginput(1)
keyboard
l3 = ginput(1)
keyboard
l4 = ginput(1)
keyboard
le = [l1;l2;l3;l4]

le = lin
count = 1
d2 = []
for i = 1:(length(le(:,1))-1)
    for j = i+1:length(le)
        diff = le(i,:)-le(j,:);
        d2(count) =  sum(sqrt((diff(:,1).^2)+(diff(:,2).^2)),2)
        count = count+1
    end
end

pxpm = d./rDs
mpx = mean(pxpm)
spx = std(pxpm)

return
%%

load('D:\Field_data\2013\Summer\Images\JWC\Aug07\GL19\Photogrammetry\GL19PG1ST1\IMG_519_analysis\scales2d.mat','le','dist')



l1 = ginput(2)
l2 = ginput(2)
l3 = ginput(2)
l4 = ginput(2)

le = [l1;l2;l3;l4]

count = 1
d2 = []
for i = 1:(length(le(:,1))-1)
    for j = i+1:length(le)
        diff = le(i,:)-le(j,:);
        d2(count) =  sum(sqrt((diff(:,1).^2)+(diff(:,2).^2)),2)
        count = count+1
    end
end

dist2 = d2./dist
% save('D:\Field_data\2013\Summer\Images\JWC\Aug07\GL19\Photogrammetry\GL19PG1ST1\IMG_519_analysis\scales2d.mat','le','dist')

return
lin = le
for i = 1:length(lin(:,1))
    hold on
    plot(lin(i,1),lin(i,2),'yo')
    text(lin(i,1)+5,lin(i,2),num2str(i),'color',[1 0 0],'fontsize',14)
end
savefig('D:\Field_data\2013\Summer\Images\JWC\Aug07\GL19\Photogrammetry\GL19PG1ST1\IMG_519_analysis\figScales')
return

diff = lin(2:end,:)-lin(1:end-1,:);
d =  sum(sqrt((diff(:,1).^2)+(diff(:,2).^2)),2)
d = d(1:2:end)

realLength = 0.25

pxpm = mean(d/realLength)

%% just to get the distance in pixels

l1 = ginput(2)

diff = l1(2,:)-l1(1,:);
d =  sum(sqrt((diff(:,1).^2)+(diff(:,2).^2)),2)

l = d/0.28
