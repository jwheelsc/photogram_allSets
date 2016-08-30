function moveDown_button(source, callbackdata)
   
msfc = source.UserData.scale
[msfc,ws,ol] = msfcFunc()

xl2 = get(gca,'xlim')
yl2 = get(gca,'ylim')
ylim([yl2(2)-(ol/msfc) yl2(2)+((ws-ol)/msfc)])
xlim(xl2)
    