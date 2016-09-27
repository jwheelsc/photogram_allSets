clear all
close all
% 
[folder, subFolder, imgNum, setIn, imSave, msfc, ws, ol] = whatFolder(7)
folderStr = [folder subFolder setIn]

df = 10
num_h = 5
% 
load(folderStr)
setNum = 'allSets'
jsets = {}

%% densify the sets
dts = 0
if dts == 1
    for i = 1:length(allSets)
%         sz = size(allSets{i})
% %         if sz(1)<2
% %             i
% %             keyboard
% %         end

        dense_jsets{i} = densify_lines(allSets{i},msfc);

    end
end
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
% close all
% f1 = figure('units','normalized','outerposition',[0 0 1 1])
% 
% for i = 1:length(allSets)
% % for i =282
%     hold on
%     p = dense_jsets{i};
%     ph(i)=plot(p(:,1)',p(:,2)','k.+','linewidth',1);
% end

xlim([minx maxx]);
ylim([miny maxy]);

scales = 1/(msfc);
length_x = (maxx-minx)/(scales);
length_y = (maxy-miny)/(scales);
area_xy = (length_x*length_y);

hS = num2str(num_h)

save([folder subFolder 'results_' hS '.mat'],'length_x','length_y','area_xy')


%% create a scaline line, and find the intersections
yr = maxy-miny;

h = sqrt(area_xy*(scales.^2))/num_h
critical_d = sqrt(area_xy*(scales.^2))/750
thetaA = [1:5:186];
% thetaA = [76:5:101];
% thetaA = 136
%%

for t = 1:length(thetaA)

    theta = thetaA(t);
    m_sl = tan(theta*pi/180); %slope in radians
    B = abs(h/sin((90-theta)*pi/180)); %this is the offset in y for lines a distance of h apart
    if theta < 90
        bf = (m_sl*minx)/B %the scale factor for the first intercept that will keep the upper line in the box
        b_sl = maxy-(B*bf) %the first intercept
        max_l = floor((miny-(m_sl*maxx)-maxy)/-B)-ceil(bf) % the number of lines that will be in the box
    else 
        bf = (miny-(m_sl*minx))/B;
        b_sl = B*bf
        max_l = floor((maxy-(m_sl*maxx))/B)-ceil(bf)
    end

    count = 1;
    min_x_line = 0;

    set_int = {};
    line_length = [];

%     close all
%     f1 = figure('units','normalized','outerposition',[0 0 1 1])
% 
%     for i = 1:length(allSets)
%     % for i =282
%         hold on
%         p = allSets{i};
%         sz = size(p)';
%         if sz(1)>=2
%             ph(i)=plot(p(:,1)',p(:,2)','k-','linewidth',1);
%         end
%     end

    xlim([minx maxx])
    ylim([miny maxy])

    
    if theta < 90
        
        for l = 1:max_l

            b_sl = b_sl-B;
            
            %%%this is for plottting the scanline
            min_x_line = (miny-b_sl)/m_sl;
            
            pa = [(maxy-b_sl)/m_sl,maxy];
            pb = [maxx,m_sl*maxx+b_sl];
            pc = [minx, m_sl*minx+b_sl];
            pd = [(miny-b_sl)/m_sl,miny];
            pA = [pa;pb;pc;pd];
            [ps,pind] = sort(pA(:,1));
            p1 = pA(pind(2),:);
            p2 = pA(pind(3),:);
            
            line_length(l) = sqrt(sum((p2-p1).^2));
                
            hold on
            plot([p1(1) p2(1)],[p1(2) p2(2)],'m-')
            
            %%% this is for finding the intersection
            int_point = []
            for ji = 1:length(allSets)
                
                js = allSets{ji};
                y = js(:,2);
                x = js(:,1);
                m_j = (y(2:end)-y(1:end-1))./(x(2:end)-x(1:end-1));
 
                m_j(isnan(m_j))=0;
                m_j(isinf(m_j))=1e4;
                b_j = y(2:end)-(m_j.*x(2:end));
                
                xi = (b_j-b_sl)./(m_sl-m_j);
                xi(isnan(xi))=0;
                xi(isinf(xi))=0;
                yi = m_sl.*xi+b_sl;
                yi(isnan(yi))=0;
                yi(isinf(yi))=0;
                
                d1 = sqrt((xi-x(1:end-1)).^2+(yi-y(1:end-1)).^2);
                d2 = sqrt((xi-x(2:end)).^2+(yi-y(2:end)).^2);
                d3 = sqrt((x(1:end-1)-x(2:end)).^2+(y(1:end-1)-y(2:end)).^2);
                inBox = logical((d1<d3).*(d2<d3));
                int_point = [int_point;[xi(inBox),yi(inBox)]];
                
            end
            set_int{end+1}= int_point;
%             hold on
%             plot(int_point(:,1),int_point(:,2),'bo')
%             
%             keyboard
        end
    end

    min_y_line = 0;
    if theta > 90
        for l = 1:max_l

            b_sl = b_sl+B;

            min_y_line = m_sl*maxx+b_sl;
           
            pa = [(maxy-b_sl)/m_sl,maxy];
            pb = [maxx,m_sl*maxx+b_sl];
            pc = [minx, m_sl*minx+b_sl];
            pd = [(miny-b_sl)/m_sl,miny];
            pA = [pa;pb;pc;pd];
            [ps,pind] = sort(pA(:,1));
            p1 = pA(pind(2),:);
            p2 = pA(pind(3),:);
            
            line_length(l) = sqrt(sum((p2-p1).^2));

%             hold on
%             plot([p1(1) p2(1)],[p1(2) p2(2)],'m-')
                       %%% this is for finding the intersection
            int_point = []
            for ji = 1:length(allSets)
                
                js = allSets{ji};
                y = js(:,2);
                x = js(:,1);
                m_j = (y(2:end)-y(1:end-1))./(x(2:end)-x(1:end-1));
 
                m_j(isnan(m_j))=0;
                m_j(isinf(m_j))=1e4;
                b_j = y(2:end)-(m_j.*x(2:end));
                
                xi = (b_j-b_sl)./(m_sl-m_j);
                xi(isnan(xi))=0;
                xi(isinf(xi))=0;
                yi = m_sl.*xi+b_sl;
                yi(isnan(yi))=0;
                yi(isinf(yi))=0;
                
                d1 = sqrt((xi-x(1:end-1)).^2+(yi-y(1:end-1)).^2);
                d2 = sqrt((xi-x(2:end)).^2+(yi-y(2:end)).^2);
                d3 = sqrt((x(1:end-1)-x(2:end)).^2+(y(1:end-1)-y(2:end)).^2);
                inBox = logical((d1<d3).*(d2<d3));
                int_point = [int_point;[xi(inBox),yi(inBox)]];
                
            end
            set_int{end+1}= int_point;
%             hold on

%             keyboard
        end
    end

%     pause(2)
%     keyboard
    axis equal
    save([folder subFolder 'sl_pts_' num2str(theta) '_' setNum '_' hS '.mat'], 'set_int', 'line_length')
    %% putting the keyboard command here allows you to pause at each set
    %% on scanlines. 
%     keyboard
end

return

savePDFfunction(f1,[folder subFolder 'scanline_intersect' imSave '_' hS])


%% in this section you can find the number of joint sets that intersect the edges of the domain

close all
f1 = figure

critical_d = critical_d*5

for i = 1:length(allSets)
% for i =282
    hold on
    p = allSets{i};
    ph(i)=plot(p(:,1)',p(:,2)','k-','linewidth',1);
end

%%% left edge

SN =  dense_jsets;

count = 1
jL = []
for i = 1:length(SN);
    jnt = SN{i};    
    el = find(abs(jnt(:,1)-minx)<critical_d);
    if isempty(el)==0
        jL(count) = i
        count = count+1;
        hold on
        plot(jnt(:,1),jnt(:,2),'b.','markersize',10)
    end
end

%%% right edge

count = 1;
jR = [];
for i = 1:length(SN)
    jnt = SN{i};    
    el = find(abs(jnt(:,1)-maxx)<critical_d);
    if isempty(el)==0
        jR(count) = i
        count = count+1;        
        hold on
        plot(jnt(:,1),jnt(:,2),'b.','markersize',10)
    end
end

%%% upper edge

count = 1
jU = []
for i = 1:length(SN)
    jnt = SN{i};    
    el = find(abs(jnt(:,2)-maxy)<critical_d);
    if isempty(el)==0
        jU(count) = i
        count = count+1;
        hold on
        plot(jnt(:,1),jnt(:,2),'b.','markersize',10)
    end
end

%%% lower edge

count = 1;
jLw = [];
for i = 1:length(SN)
    jnt = SN{i};    
    el = find(abs(jnt(:,2)-miny)<critical_d);
    if isempty(el)==0
        jLw(count) = i
        count = count+1;
        hold on
        plot(jnt(:,1),jnt(:,2),'b.','markersize',10)
    end
    
end

ljLw = length(jLw)
ljR = length(jR)
ljU = length(jU)
ljL = length(jL)

ljT = ljLw+ljR+ljU+ljL

etf = ([ljLw,ljR,ljU,ljL,ljT]'/length(allSets))*100
et = [ljLw,ljR,ljU,ljL,ljT]'

save([folder subFolder 'results.mat'],'etf','et')
savePDFfunction(f1,[folder subFolder 'edges' imSave])




















