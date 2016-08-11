function moveRight_button(source, callbackdata)
   
msfc = source.UserData.scale

xl2 = get(gca,'xlim')
yl2 = get(gca,'ylim')
xlim([xl2(2)-(0.25/msfc) xl2(2)+(1.75/msfc)])
ylim(yl2)
    