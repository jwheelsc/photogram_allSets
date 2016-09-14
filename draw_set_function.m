function draw_set_function(source, callbackdata)


iNum = source.UserData.imNum
[folder, subFolder, imgNum, setIn, imSave, msfc, ws, ol] = whatFolder(iNum)
folderStr = [folder subFolder 'limits.mat']

xlm = get(gca,'xlim')
ylm = get(gca,'ylim')

save(folderStr,'xlm','ylm')
run D:\Code\photog_allSets\draw_and_plot_Sets.m
