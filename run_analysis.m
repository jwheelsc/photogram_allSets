
clear all
close all

iA = [9:21]
cellNA = ['Y','X','Z','AA','AB','AC','AD','AE','AF','AH','S','R','O']
% for ii = 1:length(cellNA)
for iii = 1:length(iA)
    
    ii = iA(iii)
    cellN = cellNA(iii)
    [folder, subFolder, imgNum, setIn, imSave, msfc, ws, ol] = whatFolder(ii)
    folderStr = [folder subFolder setIn]
    load(folderStr)    
    
    %% get rid of 1 line points
    count = 1
    for i = 1:length(allSets)
        a = allSets{i};
        if length(a(:,1))>1
            allSets2{count} = a;
            count = count+1;
        end
    end

    allSets = allSets2
    %%
    
    run analyze_sets_intersections.m
end
% 
%     return
%     
%     run findWindowSize
% %     run windowEdges
%     
% %     run analyze_sets_intersections.m
% 
%     thetaA = [1:5:186];
%     num_hA = [5,10,20];
%     
%     for jjj = 1:length(num_hA)
%     
% %         run draw_and_plot_Sets.m %% this one you might to comment out some things
% %         keyboard
%         
%         num_h = num_hA(jjj)
%        
%         run analyze_sets.m
%         keyboard
% 
%         run sets_stats.m
%         keyboard
% 
%         run computeFrequency.m
%         keyboard
% 
% %         load([folder subFolder 'results_' hS '.mat'])
% 
% %         ['the max frequency is ' num2str(mxy)]
% %         ['the min frequency is ' num2str(mny)]
% %         ['the mean frequency is ' num2str(mean_fq)]
% %         ['the average joint length is ' num2str(mean_l)]
% %         ['there are ' num2str(num_joints) ' joints']
% %         ['the total joint length is ' num2str(sum_length)]
% %         ['there are ' num2str(totalints) ' intersections']
% %         ['the length in x is ' num2str(length_x)]
% %         ['the length in y is ' num2str(length_y)]
% %         ['the area  ' num2str(area_xy)]
% 
%         if jjj == 1
%             cellRange = [cellN '46:' cellN '48']
%         elseif jjj == 2
%             cellRange = [cellN '51:' cellN '53']
%         elseif jjj == 3
%             cellRange = [cellN '56:' cellN '58']
%         end
%         
%         A = [mxy,mny,mean_fq]'
%         xlswrite('D:\Field_data\2013\Summer\Geotech\outcrop_disctontinuity.xlsx',A,cellRange)
%         
%     end
%     
% %     load([folder subFolder 'results_intersections.mat'])
%     B = [mean_l,num_joints,sum_length,totalints,totalints/area_xy,...
%         sum_length/area_xy,num_joints/area_xy,length_x,length_y,area_xy]'
%     cellRange = [cellN '60:' cellN '69']
%     xlswrite('D:\Field_data\2013\Summer\Geotech\outcrop_disctontinuity.xlsx',B,cellRange)
%     cellRange = [cellN '72:' cellN '76']
%     xlswrite('D:\Field_data\2013\Summer\Geotech\outcrop_disctontinuity.xlsx',etf,cellRange)
%     cellRange = [cellN '79:' cellN '83']
%     xlswrite('D:\Field_data\2013\Summer\Geotech\outcrop_disctontinuity.xlsx',et,cellRange)
%     cellRange = [cellN '85:' cellN '85']
%     xlswrite('D:\Field_data\2013\Summer\Geotech\outcrop_disctontinuity.xlsx',et,cellRange)
%     
% end
% 


