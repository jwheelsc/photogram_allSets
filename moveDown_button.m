function moveDown_button(source, callbackdata)
   
iNum = source.UserData.imNum
[folder, subFolder, imgNum, setIn, imSave, msfc, ws, ol] = whatFolder(iNum)
folderStr = [folder subFolder setIn]
load(folderStr)

xl2 = get(gca,'xlim')
yl2 = get(gca,'ylim')
ylim([yl2(2)-(ol/msfc) yl2(2)+((ws-ol)/msfc)])
xlim(xl2)
    