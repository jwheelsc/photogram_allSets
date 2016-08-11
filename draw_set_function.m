function draw_set_function(source, callbackdata)

[folder, subFolder, imgNum, setIn] = whatFolder()
folderStr = [folder subFolder 'limits.mat']

xlm = get(gca,'xlim')
ylm = get(gca,'ylim')

save(folderStr,'xlm','ylm')
run D:\Code\photog_allSets\draw_and_plot_Sets.m
