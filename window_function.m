function window_function(source, callbackdata)
%DRAW_LINE_FUNCTION Summary of this function goes here
%   Detailed explanation goes here

[folder, subFolder, imgNum, setIn] = whatFolder()
folderStr = [folder subFolder setIn]
load(folderStr)

val = source.Value
source.String(val)

xlm = source.UserData.xl
ylm = source.UserData.yl
msfc = source.UserData.scale

if strcmp(source.String(val),'full image')

    xlim(xlm)
    ylim(ylm)
    
elseif strcmp(source.String(val),'ul_q')

    xlim([0 xlm(2)/2])
    ylim([0 ylm(2)/2])
    
elseif strcmp(source.String(val),'ur_q')

    xlim([xlm(2)/2 xlm(2)])
    ylim([0 ylm(2)/2])
    
elseif strcmp(source.String(val),'ll_q')

    xlim([0 xlm(2)/2])
    ylim([ylm(2)/2 ylm(2)])
    
elseif strcmp(source.String(val),'lr_q')

    xlim([xlm(2)/2 xlm(2)])
    ylim([ylm(2)/2 ylm(2)])
    
elseif strcmp(source.String(val),'TOP LEFT')

    xlim([0 (2/msfc)])
    ylim([0 (2/msfc)])
    
elseif strcmp(source.String(val),'move right')
    
    xl2 = get(gca,'xlim')
    yl2 = get(gca,'ylim')
    xlim([xl2(2)-(0.25/msfc) xl2(2)+(1.75/msfc)])
    ylim([0 (2/msfc)])
    
elseif strcmp(source.String(val),'move left')
    
    xl2 = get(gca,'xlim')
    yl2 = get(gca,'ylim')
    xlim([xl2(1)-(1.75/msfc) xl2(1)+(0.25/msfc)])
    ylim([0 (2/msfc)])
    
    elseif strcmp(source.String(val),'move down')
    
    xl2 = get(gca,'xlim')
    yl2 = get(gca,'ylim')
    ylim([yl2(2)-(0.25/msfc) yl2(2)+(1.75/msfc)])
    xlim([0 (2/msfc)])
    
elseif strcmp(source.String(val),'move up')
    
    xl2 = get(gca,'xlim')
    yl2 = get(gca,'ylim')
    ylim([yl2(1)-(1.75/msfc) yl2(1)+(0.25/msfc)])
    xlim([0 (2/msfc)])
    
    elseif strcmp(source.String(val),'move 1 right')
    
    xl2 = get(gca,'xlim')
    yl2 = get(gca,'ylim')
    xlim([xl2(2) xl2(2)+(2/msfc)])
    ylim([0 (2/msfc)])
    
elseif strcmp(source.String(val),'move 1 left')
    
    xl2 = get(gca,'xlim')
    yl2 = get(gca,'ylim')
    xlim([xl2(1)-(2/msfc) xl2(1)])
    ylim([0 (2/msfc)])
    
    elseif strcmp(source.String(val),'move 1 down')
    
    xl2 = get(gca,'xlim')
    yl2 = get(gca,'ylim')
    ylim([yl2(2) yl2(2)+(2/msfc)])
    xlim([0 (2/msfc)])
    
elseif strcmp(source.String(val),'move 1 up')
    
    xl2 = get(gca,'xlim')
    yl2 = get(gca,'ylim')
    ylim([yl2(1)-(2/msfc) yl2(1)])
    xlim([0 (2/msfc)])
    
end

end

