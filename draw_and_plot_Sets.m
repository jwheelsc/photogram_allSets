%%% here are some commands that you can use to trace out joint sets in
%%% images in matlab, then if you want to plot the traces you can run this
%%% scripts

% clear all
% close all
% iNum = 26
% [folder, subFolder, imgNum, setIn, imSave, msfc, ws, ol] = whatFolder(iNum)
% folderStr = [folder subFolder setIn]

close all
% f1 = figure('units','normalized','outerposition',[0 0 1 1])
f1 = figure
% A = imread([folder imgNum]);
% B = imresize(A,1/13);
% imshow(B)

imshow([folder imgNum])

xlms = get(gca,'xlim')
ylms = get(gca,'ylim')
% xlms = [1944 3213] 
% ylms = [1296 2160]
% 

% xlms = [599 3792]
% ylms = [675 2293]
% 
% xlms = [53 288]
% ylms = [52 176]

% xlms = [1351 4310] this is gl2 oco2 good res
% ylms = [557 2505]
% xlms = [105 331] %this is gl2 oco2 bad res
% ylms = [44 194]

% return
lxl = xlms(1)
uxl = xlms(2)
lyl = ylms(1)
uyl = ylms(2)
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
save(folderStr,'allSets')
end

%%

% for i = round(length(allSets)*0.5):length(allSets)
for i = 1:length(allSets)
    hold on
    p = allSets{i};
    ph(i)=plot(p(:,1)',p(:,2)','b','linewidth',1);
    ely = find(p(:,2)==max(p(:,2)));
    ely = ely(end);
%     text(p(ely,1),p(ely,2),num2str(i),'fontsize',9,'color', 'k');
end

twoMbar = 2/msfc
hold on 
plot([uxl-(2.2/msfc) uxl-(0.2/msfc)],[uyl-(1/msfc) uyl-(1/msfc)],'y','linewidth',4)
text([uxl-(3/msfc)],[uyl-(1.2/msfc)],'2 meters','fontsize',10,'color','y')

f1 = gcf
savePDFfunction(f1,[folder subFolder 'trace' imSave])
savefig([folder subFolder 'trace' imSave '.fig'])
return

%% find the traces that are longer than the window size, but you only want
%%% to run this if your not plotting all traces

plotFewerTraces = 0

if plotFewerTraces == 1
    traceL = getLineLength(allSets)
    rtl = traceL*msfc
%     el = find(rtl>sqrt(2*ws^2))
    el = find(rtl>ws)
    
    for i = 1:length(el)
        hold on
        p = allSets{el(i)};
        ph(i)=plot(p(:,1)',p(:,2)','r','linewidth',1);
        ely = find(p(:,2)==max(p(:,2)));
        ely = ely(end);
        text(p(ely,1),p(ely,2),num2str(el(i)),'fontsize',9,'color', 'k');
    end

end
%%


xlm = get(gca,'xlim')
ylm = get(gca,'ylim')

popup = uicontrol('Style', 'pushbutton',...
   'String', 'create line',...
   'Position', [1100 535 80 50],...
   'UserData', struct('imNum',iNum),...
   'Callback', @draw_line_function); 

popup = uicontrol('Style', 'pushbutton',...
   'String', 'break line',...
   'Position', [1100 500 80 30],...
   'UserData', struct('imNum',iNum),...
   'Callback', @break_loop_function); 

% text(1.12,0.78,'redo line','units','normalized')
popup = uicontrol('Style', 'pushbutton',...
   'String', 'redo line',...
   'Position', [1100 400 80 50],...
   'UserData', struct('imNum',iNum),...
   'Callback', @redo_line_function); 

% text(1.12,0.58,'append line','units','normalized')
popup = uicontrol('Style', 'pushbutton',...
   'String', 'append line',...
   'Position', [1100 300 80 50],...
   'UserData', struct('imNum',iNum),...
   'Callback', @append_line_function); 

btn = uicontrol('Style', 'pushbutton', 'String', 'move right',...
    'Position', [1100 175 80 30],...
    'UserData', struct('xl',xlm,'yl',ylm,'imNum',iNum),...
    'Callback', @moveRight_button); 

btn = uicontrol('Style', 'pushbutton', 'String', 'move down',...
    'Position', [1100 137.5 80 30],...
    'UserData', struct('xl',xlm,'yl',ylm,'imNum',iNum),...
    'Callback', @moveDown_button); 

popup = uicontrol('Style', 'popup',...
   'String', {'full image','ul_q','ur_q','ll_q','lr_q','TOP LEFT',...
   'move left','move right','move up','move down',...
   'move 1 left','move 1 right','move 1 up','move 1 down'},...
   'Position', [1100 200 80 50],...
   'UserData', struct('xl',xlm,'yl',ylm,'imNum',iNum),...
   'Callback', @window_function); 

btn = uicontrol('Style', 'pushbutton',...
        'String', 'Draw set',...
        'Position', [1100 90 80 30],...
        'UserData', struct('imNum',iNum),...
        'Callback', @draw_set_function);

btn = uicontrol('Style', 'pushbutton',...
        'String', 'return window',...
        'Position', [1100 90-37.5 80 30],...
        'UserData', struct('imNum',iNum),...
        'Callback', @lastWindow_function);


        
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
[folder, subFolder, imgNum, setIn, imSave, msfc, ws, ol] = whatFolder(iNum)
folderStr = [folder subFolder setIn]

load(folderStr)
close all

pt = 3327

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
    save(folderStr,'allSets')
end

%% delete points outside the bounding box
% clear all
xlim=[lxl uxl]
ylim=[lyl uyl]
[folder, subFolder, imgNum, setIn, imSave, msfc, ws, ol] = whatFolder(iNum)
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
    allSets = SN
    save(folderStr,'allSets')
end


%% if you deleted lines outside an inner bounding box, then you'll need to get rid of them as

count = 1;
for i = 1:length(allSets)
    
    if size(allSets{i},1) ~= 0; 
        jnt{count} = allSets{i}; 
        count = count+1;
    end
end

RESAVE = 0
if RESAVE == 1
    allSets = jnt
    save(folderStr,'allSets')
end


%% ensure all sets go from left to right
crack_arr = {}
for i = 1:length(allSets)
    crack = allSets{i}
    if crack(1,1)>crack(end,1)
        crack_arr{i} = crack(end:-1:1,:)
    else
        crack_arr{i} = crack
    end
end
allSets = crack_arr
% save(folderStr,'allSets')
    







