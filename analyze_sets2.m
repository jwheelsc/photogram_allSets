% clear all
% close all
% % 
% [folder, subFolder, imgNum, setIn, imSave, msfc, ws, ol] = whatFolder(7)
% folderStr = [folder subFolder setIn]
% num_h = 5
% 
% load(folderStr)
% jsets = {}

%% plot all the lines
close all
f1 = figure('units','normalized','outerposition',[0 0 1 1])

for i = 1:length(allSets)
% for i =282
    hold on
    p = allSets{i};
    ph(i)=plot(p(:,1)',p(:,2)','k-','linewidth',1);
end


%% now loop through all angles

setNum = 'allSets'

h = sqrt(area_xy*(scales.^2))/num_h
hS = num2str(num_h)

% thetaA = [1:5:186];

for t = 1:length(thetaA)

    theta = thetaA(t)
    m_sl = tan(theta*pi/180); %slope in radians
    B = abs(h/sin((90-theta)*pi/180)); %this is the offset in y for lines a distance of h apart
    if theta < 90
        bf = (m_sl*minx)/B; %the scale factor for the first intercept that will keep the upper line in the box
        b_sl = maxy-(B*bf); %the first intercept
        max_l = floor((miny-(m_sl*maxx)-maxy)/-B)-ceil(bf); % the number of lines that will be in the box
    else 
        bf = (miny-(m_sl*minx))/B;
        b_sl = B*bf;
        max_l = floor((maxy-(m_sl*maxx))/B)-ceil(bf);
    end

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
            int_point = [];
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
            hold on
            plot(int_point(:,1),int_point(:,2),'bo')
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

            hold on
            plot([p1(1) p2(1)],[p1(2) p2(2)],'m-')
           %%% this is for finding the intersection
            int_point = [];
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
            hold on
            plot(int_point(:,1),int_point(:,2),'bo')
        end
    end

    pause(0.1)
    savePDFfunction(f1,['D:\Documents\Presentations\NWG2016\scanline\SI_' num2str(theta)])
%     keyboard
%     axis equal
%     save([folder subFolder 'sl_pts_' num2str(theta) '_' setNum '_' hS '.mat'], 'set_int', 'line_length')
end

% savePDFfunction(f1,[folder subFolder 'scanline_intersect' imSave '_' hS])
% 




















