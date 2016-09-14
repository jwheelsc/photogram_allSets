function moveRight_button(source, callbackdata)
   
iNum = source.UserData.imNum
[folder, subFolder, imgNum, setIn, imSave, msfc, ws, ol] = whatFolder(iNum)
folderStr = [folder subFolder setIn]
load(folderStr)

xl2 = get(gca,'xlim')
yl2 = get(gca,'ylim')
xlim([xl2(2)-(ol/msfc) xl2(2)+((ws-ol)/msfc)])
ylim(yl2)
    