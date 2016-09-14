% clear variables
% close all
% % 
% [folder, subFolder, imgNum, setIn, imSave, msfc, ws, ol] = whatFolder(i)
% folderStr = [folder subFolder setIn]
% load(folderStr)

close all
%% find some bounding boxesthe bounding box of the entire set
for i = 1:length(allSets)
    lin = allSets{i};
    mnx(i) = min(lin(:,1));
    mny(i) = min(lin(:,2));
    mxx(i) = max(lin(:,1));
    mxy(i) = max(lin(:,2));
end 
miny = min(mny)
maxy = max(mxy)
minx = min(mnx)
maxx = max(mxx)

%% plot all the lines
% hold on
% f1 = figure('units','normalized','outerposition',[0 0 1 1])

for i = 1:length(allSets)
% for i =282
    hold on
    p = allSets{i};
    ph(i)=plot(p(:,1)',p(:,2)','k','linewidth',1);
end

xlim([minx maxx])
ylim([miny maxy])
% length_x = (maxx-minx)/(141)
% length_y = (maxy-miny)/(141)
% area_xy = (length_x*length_y)



%% densify the sets
densifyLines = 1
if densifyLines == 1
    for i = 1:length(allSets)
        sz = size(allSets{i})
%         if sz(1)<2
%             i
%             keyboard
%         end

        dense_jsets{i} = densify_lines(allSets{i});

    end
    allSets = dense_jsets

%     f2 = figure('units','normalized','outerposition',[0 0 1 1])
% 
%     for i = 1:length(allSets)
%     % for i =282
%         hold on
%         p = dense_jsets{i};
%         ph(i)=plot(p(:,1)',p(:,2)','k','linewidth',1);
%     end
% 
%     xlim([minx maxx])
%     ylim([miny maxy])
end
%% how much does a set intersect itself?

intPts = []
count = 1
for i = 1:length(allSets)-1
    
    j1 = allSets{i};
    for j = i+1:length(allSets)
    
       j2 = allSets{j};
        
       jp1x = repmat(j1(:,1),[1,length(j2(:,1))])';
       jp2x = repmat(j2(:,1),[1,length(j1(:,1))]);  
       jp1y = repmat(j1(:,2),[1,length(j2(:,2))])';
       jp2y = repmat(j2(:,2),[1,length(j1(:,2))]);  

       dM = sqrt((jp2x-jp1x).^2+(jp2y-jp1y).^2);
       
       mdM = min(min(dM));
       [row,col] = find(abs(dM-mdM)<1e-3);
       row = row(end);
       col = col(end);
       if mdM < 5
           intPts(count,:) = j1(col,:);
           count = count+1;
       end
       
    end
    
end

save([folder subFolder 'setInt.mat'],'intPts')
totalints = length(intPts)


%%
load([folder subFolder 'setInt.mat'])
hold on
plot(intPts(:,1),intPts(:,2),'o')

f1 = gcf
savePDFfunction(f1,[folder subFolder 'intersect' imSave])
save([folder subFolder 'results.mat'],'totalints','-append')
















