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

[msfc,ws,ol] = msfcFunc()

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

    xlim([xlm(1) xlm(1)+(ws/msfc)])
    ylim([ylm(1) ylm(1)+(ws/msfc)])
    
elseif strcmp(source.String(val),'move right')
    
    xl2 = get(gca,'xlim')
    yl2 = get(gca,'ylim')
    xlim([xl2(2)-(ol/msfc) xl2(2)+((ws-ol)/msfc)])
    ylim([yl2(1) yl2(2)])
    
elseif strcmp(source.String(val),'move left')
    
    xl2 = get(gca,'xlim')
    yl2 = get(gca,'ylim')
    xlim([xl2(1)-((ws-ol)/msfc) xl2(1)+(ol/msfc)])
    ylim([yl2(1) yl2(2)])
    
    elseif strcmp(source.String(val),'move down')
    
    xl2 = get(gca,'xlim')
    yl2 = get(gca,'ylim')
    ylim([yl2(2)-(ol/msfc) yl2(2)+((ws-ol)/msfc)])
    xlim([xl2(1) xl2(2)])
    
elseif strcmp(source.String(val),'move up')
    
    xl2 = get(gca,'xlim')
    yl2 = get(gca,'ylim')
    ylim([yl2(1)-((ws-ol)/msfc) yl2(1)+(ol/msfc)])
    xlim([xl2(1) xl2(2)])
    
    elseif strcmp(source.String(val),'move 1 right')
    
    xl2 = get(gca,'xlim')
    yl2 = get(gca,'ylim')
    xlim([xl2(2) xl2(2)+(ws/msfc)])
    ylim([yl2(1) yl2(2)])
    
elseif strcmp(source.String(val),'move 1 left')
    
    xl2 = get(gca,'xlim')
    yl2 = get(gca,'ylim')
    xlim([xl2(1)-(ws/msfc) xl2(1)])
    ylim([yl2(1) yl2(2)])
    
    elseif strcmp(source.String(val),'move 1 down')
    
    xl2 = get(gca,'xlim')
    yl2 = get(gca,'ylim')
    ylim([yl2(2) yl2(2)+(ws/msfc)])
    xlim([xl2(1) xl2(2)])
    
elseif strcmp(source.String(val),'move 1 up')
    
    xl2 = get(gca,'xlim')
    yl2 = get(gca,'ylim')
    ylim([yl2(1)-(ws/msfc) yl2(1)])
    xlim([xl2(1) xl2(2)])
    
end

end

