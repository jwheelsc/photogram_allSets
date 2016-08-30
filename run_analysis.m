
clear all
close all

for i = 14
    
    [folder, subFolder, imgNum, setIn, imSave, msfc, ws, ol] = whatFolder(i)
    folderStr = [folder subFolder setIn]
    load(folderStr)

    
    run draw_and_plot_Sets.m

    run analyze_sets.m

    run sets_stats.m

    run sets_stats_fnc_noPlot.m

    run analyze_sets_intersections.m

end

return

%%
    clear all

    [folder, subFolder, imgNum, setIn, imSave] = whatFolder(14)
    load([folder subFolder 'results.mat'])

    ['the max frequency is ' num2str(mxy)]
    ['the min frequency is ' num2str(mny)]
    ['the mean frequency is ' num2str(mean_fq)]
    ['the average joint length is ' num2str(mean_l)]
    ['there are ' num2str(num_joints) ' joints']
    ['the total joint length is ' num2str(sum_length)]
    ['there are ' num2str(totalints) ' intersections']
    ['the length in x is ' num2str(length_x)]
    ['the length in y is ' num2str(length_y)]
    ['the area  ' num2str(area_xy)]
    


