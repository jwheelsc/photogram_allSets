function break_loop_function(source, callbackdata)


iNum = source.UserData.imNum
[folder, subFolder, imgNum, setIn, imSave, msfc, ws, ol] = whatFolder(iNum)
folderStr = [folder subFolder 'looping.mat']

loops = 'no'

save(folderStr,'loops')
