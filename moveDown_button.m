function moveDown_button(source, callbackdata)
   
msfc = source.UserData.scale

xl2 = get(gca,'xlim')
yl2 = get(gca,'ylim')
ylim([yl2(2)-(0.25/msfc) yl2(2)+(1.75/msfc)])
xlim(xl2)
    