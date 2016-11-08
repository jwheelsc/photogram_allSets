
clear all
close all

imTextA =  {'Glacier 01-9049','Glacier 01-9228','Glacier 01-0119',...
    'Glacier 02-0413-hr','Glacier 02-0413-lr','Glacier 02-0413-mr',...
    'Glacier 02-0417','Glacier 04-0905','Glacier 05-1103','Glacier 06-1259',...
    'Glacier 07-1343','Glacier 08-1514','Glacier 09-0071','Glacier 11-0273',...
    'Glacier 14-0305','Glacier 14-0231','Glacier 15-0448','Glacier 16-0538',...
    'Glacier 16-0538-b','Glacier 17-0632','Glacier 18-0259','Glacier 19-0519',...
    'Glacier 20-0794'}

glLabsA = {'1a','1b','1c','2_{hr}','2_{lr}','2_{mr}','2c','4','5','6','7','8','9','11','14a','14b','15','16','16b','17','18','19','20'}
iA = [25 23 24 27 26 30 4 21 5 6 20 19 7 8 10 9 11 12 29 15 16 17 18]
cellNA = [{'E','G','I','L','M','N','O','Q','R','S','T','U','V','X',...
    'Z','AA','AC','AD','AG','AH','AI','AJ','AL'}]
% for iii = 1:length(iA)
    for iii = find(strcmp(glLabsA,'7'))
 
    ii = iA(iii)
    cellN = cellNA(iii)
% ii  = 5
    [folder, subFolder, imgNum, setIn, imSave, msfc, ws, ol] = whatFolder(ii)
    folderStr = [folder subFolder setIn]
    load(folderStr)    
    
    % get rid of 1 line points
    count = 1
    for i = 1:length(allSets)
        a = allSets{i};
        if length(a(:,1))>1
            allSets2{count} = a;
            count = count+1;
        end
    end

    allSets = allSets2
%     
    run findWindowSize
    xlms = [minx maxx]
    ylms = [miny maxy]
    glLabs = glLabsA(iii)
    imText = imTextA{iii}
    thetaA = [1:5:176];
    num_h = 40
    hS = num2str(num_h)
%     run analyze_sets.m
%     run computeFrequency.m
%     return
    run analyze_sets_intersections.m 
    return
    cellRange = [cellN{1} '3:' cellN{1} '6']
    xlswrite('D:\Field_data\2013\Summer\Geotech\outcrop_disctontinuity.xlsx',mAng,3,cellRange)
    
end

return

    %%
    
    run findWindowSize
    run windowEdges
%     %%
    run sets_stats.m
%     run analyze_sets_intersections.m
%     %%
%     run draw_and_plot_Sets.m %% this one you might to comment out some things
% %     keyboard

    %%
    thetaA = [1:5:176];
    num_hA = [5,10,20,40];
    num_h = 60 
    hS = num2str(num_h)
    
%     for jjj = 1:length(num_hA)
%         for jjj = 1:4
        
%         num_h = num_hA(jjj)
       
        run analyze_sets.m
%         keyboard

        run computeFrequency.m
%         keyboard
return
%         load([folder subFolder 'results_' hS '.mat'])

%         ['the max frequency is ' num2str(mxy)]
%         ['the min frequency is ' num2str(mny)]
%         ['the mean frequency is ' num2str(mean_fq)]
%         ['the average joint length is ' num2str(mean_l)]
%         ['there are ' num2str(num_joints) ' joints']
%         ['the total joint length is ' num2str(sum_length)]
%         ['there are ' num2str(totalints) ' intersections']
%         ['the length in x is ' num2str(length_x)]
%         ['the length in y is ' num2str(length_y)]
%         ['the area  ' num2str(area_xy)]

        if jjj == 1
            cellRange = [cellN '46:' cellN '48']
        elseif jjj == 2
            cellRange = [cellN '51:' cellN '53']
        elseif jjj == 3
            cellRange = [cellN '56:' cellN '58']
        elseif jjj == 4
            cellRange = [cellN '60:' cellN '62']
        end
        
        A = [mxy,mny,mean_fq]'
        xlswrite('D:\Field_data\2013\Summer\Geotech\outcrop_disctontinuity.xlsx',A,cellRange)
        
%     end
   
    load([folder subFolder 'results_intersections.mat'])
    B = [mean_l,num_joints,sum_length,totalints,totalints/area_xy,...
        sum_length/area_xy,num_joints/area_xy,length_x,length_y,area_xy]'
    cellRange = [cellN '64:' cellN '73']
    xlswrite('D:\Field_data\2013\Summer\Geotech\outcrop_disctontinuity.xlsx',B,cellRange)
    cellRange = [cellN '76:' cellN '80']
    xlswrite('D:\Field_data\2013\Summer\Geotech\outcrop_disctontinuity.xlsx',etf,cellRange)
    cellRange = [cellN '83:' cellN '87']
    xlswrite('D:\Field_data\2013\Summer\Geotech\outcrop_disctontinuity.xlsx',et,cellRange)
    cellRange = [cellN '89:' cellN '89']
    xlswrite('D:\Field_data\2013\Summer\Geotech\outcrop_disctontinuity.xlsx',std_l,cellRange)
    
% end



