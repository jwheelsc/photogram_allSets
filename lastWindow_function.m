function lastWindow_function(source, callbackdata)


iNum = source.UserData.imNum
[folder, subFolder, imgNum, setIn, imSave, msfc, ws, ol] = whatFolder(iNum)
folderStr = [folder subFolder 'limits.mat']

load(folderStr)
set(gca,'xlim',xlm)
set(gca,'ylim',ylm)
'fuck'
return
xlim(xlm)
ylim(ylm)