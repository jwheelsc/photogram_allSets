function lastWindow_function(source, callbackdata)

[folder, subFolder, imgNum, setIn] = whatFolder()
folderStr = [folder subFolder 'limits.mat']

load(folderStr)
xlim(xlm)
ylim(ylm)