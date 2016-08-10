%%% here are some commands that you can use to trace out joint sets in
%%% images in matlab, then if you want to plot the traces you can run this
%%% scripts

clear all
[folder, subFolder, imgNum, setIn] = whatFolder()
folderStr = [folder subFolder setIn]

close all

f1 = figure('units','normalized','outerposition',[0 0 1 1])
imshow([folder imgNum])
msf = 1/239.17
% return
% lxl = 826
% uxl = 3884
% lyl = 476
% uyl = 2370
% xlim([lxl uxl])
% ylim([lyl uyl])
% hold on
% plot([lxl lxl],[lyl uyl],'r-','linewidth',2)
% hold on
% plot([uxl uxl],[lyl uyl],'r-','linewidth',2)
% hold on
% plot([lxl uxl],[lyl lyl],'r-','linewidth',2)
% hold on
% plot([lxl uxl],[uyl uyl],'r-','linewidth',2)
% hold on 
% plot([uxl-141-200 uxl-200],[uyl-100 uyl-100],'y','linewidth',3)
load(folderStr)

%% if you want to inititate a set, then do the following...BUT BE CAREFUL NOT TO DELETE
%%% these sets should be saved in source control
RUNTHIS = 'No'

if strcmp(RUNTHIS,'YES')
    allSets = []
save(folderStr,'allSets','-append')
end

%%

for i = 1:length(allSets)
    hold on
    p = allSets{i};
    ph(i)=plot(p(:,1)',p(:,2)','b','linewidth',1);
end

popup = uicontrol('Style', 'popup',...
   'String', {'create line','append line','redo line','draw set'},...
   'Position', [1100 400 80 50],...
   'Callback', @draw_line_function); 
 
xlm = get(gca,'xlim')
ylm = get(gca,'ylim')

popup = uicontrol('Style', 'popup',...
   'String', {'full image','ul_q','ur_q','ll_q','lr_q','TOP LEFT',...
   'move left','move right','move up','move down',...
   'move 1 left','move 1 right','move 1 up','move 1 down'},...
   'Position', [1100 300 80 50],...
   'UserData', struct('xl',xlm,'yl',ylm,'scale',msf),...
   'Callback', @window_function); 

return


%% if you want to find a given line
pl = [1060,1788]

for i = 1:length(allSets)
    p = allSets{i};
    for j = 1:length(p)
        pr = p-pl;
        elx = find(abs(pr(:,1))<1);
        ely = find(abs(pr(:,2))<1);
        if isempty(elx) == 0 && isempty(ely) == 0
            ['this is the ' num2str(i) 'th line']
            break
        end
    end
end

%% if you need to get rid of a line, try this
[folder, subFolder, imgNum, setIn] = whatFolder()
folderStr = [folder subFolder setIn]
load(folderStr)
close all

pt = 282

% for i = 280:300
%     hold on
%     plot(allSets{i}(:,1),allSets{i}(:,2))
% end
% 
% return

for i = 1:pt-1
    newSet{i} = allSets{i};
end
for i = pt:length(allSets)-1
    newSet{i} = allSets{i+1};
end

figure
for i = 1:length(newSet)
    hold on
    p = newSet{i};
    ph(i)=plot(p(:,1)',p(:,2)','b','linewidth',1);

end

RESAVE = 0
if RESAVE == 1
    allSets = newSet
    save(folderStr,'allSets','-append')
end

%% delete points outside the bounding box
% clear all
xlim=[lxl uxl]
ylim=[lyl uyl]
[folder, subFolder, imgNum, setIn] = whatFolder()
folderStr = [folder subFolder setIn]
load(folderStr)
close all

SN = allSets

figure
for i = 1:length(SN)
    hold on
    plot(SN{i}(:,1),SN{i}(:,2))
end

for i = 1:length(SN)
    jnt = SN{i};
    jnt = jnt(jnt(:,1)>xlim(1),:);
    SN{i} = jnt;
end

for i = 1:length(SN)
    jnt = SN{i};
    jnt = jnt(jnt(:,1)<xlim(2),:);
    SN{i} = jnt;
end

for i = 1:length(SN)
    jnt = SN{i};
    jnt = jnt(jnt(:,2)>ylim(1),:);
    SN{i} = jnt;
end

for i = 1:length(SN)
    jnt = SN{i};
    jnt = jnt(jnt(:,2)<ylim(2),:);
    SN{i} = jnt;
end


figure
for i = 1:length(SN)
    hold on
    plot(SN{i}(:,1),SN{i}(:,2))
end
    
RESAVE = 0
if RESAVE == 1
    s3 = SN
    save(folderStr,'allSets','-append')
end  
    
    
    







