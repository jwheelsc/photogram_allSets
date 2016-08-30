function moveRight_button(source, callbackdata)
   
msfc = source.UserData.scale
[msfc,ws,ol] = msfcFunc()

xl2 = get(gca,'xlim')
yl2 = get(gca,'ylim')
xlim([xl2(2)-(ol/msfc) xl2(2)+((ws-ol)/msfc)])
ylim(yl2)
    