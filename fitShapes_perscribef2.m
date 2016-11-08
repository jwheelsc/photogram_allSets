clear all
close all


[dat, written] = xlsread('D:\Field_data\2013\Summer\Geotech\outcrop_disctontinuity.xlsx',1,'A1:AN102');
vars = written(:,1);
plotOn = logical(dat(strcmp(vars,'plot?'),:));
elLi = num2str(find(strcmp(vars,'rock type')));
elGt = find(strcmp(vars,'surge type'));
elRt = find(strcmp(vars,'group_rk'));
el4g = find(strcmp(vars,'group_4'));


imTextA =  {'Glacier 01-9049','Glacier 01-9228','Glacier 01-0119',...
    'Glacier 02-0413-hr','Glacier 02-0413-lr','Glacier 02-0413-mr',...
    'Glacier 02-0417','Glacier 04-0905','Glacier 05-1103','Glacier 06-1259',...
    'Glacier 07-1343','Glacier 08-1514','Glacier 09-0071','Glacier 11-0273',...
    'Glacier 14-0305','Glacier 14-0231','Glacier 15-0448','Glacier 16-0538',...
    'Glacier 16-0538-b','Glacier 17-0632','Glacier 18-0259','Glacier 19-0519',...
    'Glacier 20-0794'}

glLabsA = {'1a','1b','1c','2_{hr}','2_{lr}','2_{mr}','2c','4','5','6','7','8','9','11','14a','14b','15','16','16b','17','18','19','20'}
iA = [25 23 24 27 26 30 4 21 5 6 20 19 7 8 10 9 11 12 29 15 16 17 18]
cellNA = [{'E','G','I','L','M','N','O','Q','R','S','T','U','V','X',...
    'Z','AA','AC','AD','AG','AH','AI','AJ','AL'}]


hS = num2str(40)


for iii = 1:length(glLabsA)
% iii = find(strcmp(glLabsA,'2c'))

    ii = iA(iii)
    cellN = cellNA(iii)
    [folder, subFolder, imgNum, setIn, imSave, msfc, ws, ol] = whatFolder(ii)
    folderStr = [folder subFolder setIn]
    load(folderStr)    

    cellRange = [cellN{1} num2str(elGt)  ':' cellN{1} num2str(elGt)]
    glType = xlsread('D:\Field_data\2013\Summer\Geotech\outcrop_disctontinuity.xlsx',1,cellRange)
    data = load([folder subFolder 'results_' hS '.mat'])
    minEl = find(data.fq == min(data.fq))


    if glType == 1
       mc = [1 0 0]
    elseif glType ==2 
       mc = [0 0 1]
    end

    %%
    theta = data.thetaA
    yDat = data.fq

    if max(theta)>176
        lastEl = find(theta==176)
        theta = theta(1:lastEl)
        yDat = yDat(1:lastEl)
    end

    plot(theta,yDat,'o-')

    minFt = min(yDat) 
    minEl = find(yDat==minFt)
    theta_minFt = theta(minEl)
    el91 = find(theta==91)

    elShift = el91-minEl
    if elShift ~=0
        if elShift > 0
            firstEl = length(theta)-elShift
            yDat = [yDat(firstEl+1:end),yDat(1:firstEl)]
        end
        if elShift < 0
            elShift = minEl-el91
            firstEl = elShift
            yDat = [yDat(firstEl+1:end),yDat(1:firstEl)]
        end
        minFt = min(yDat) 
        minEl = find(yDat==minFt)
        theta_minFt = theta(minEl)
    end

    betaA = [60:0.1:120]
    for b = 1:length(betaA)

        beta = betaA(b);
        f2 = minFt/abs(cosd(theta_minFt-beta));
        f2p = f2*abs(cosd(theta-beta));

    %     close all
    %     figure
    %     plot(theta,yDat)
    %     hold on
    %     plot(theta,f2p)

        hold on 

        f2Arr = [1:0.01:4];
        for i = 1:length(f2Arr)
            f1 = f2*f2Arr(i);
            f1p = f1*abs(cosd(theta));
            ft = f1p + f2p;
    %         if f2Arr(i) == -0.25 && beta == 94
    %         hold on
    %         plot(theta,f1p,'b');
    %         hold on
    %         plot(theta,ft,'k');
    %         end
            rmsd(b,i) = sqrt(sum(((ft-yDat)/mean(yDat)).^2));
        end
    end

    %%
    fig1 = figure
    imagesc(f2Arr,betaA,rmsd)
    xlabel('f_1 multiplier')
    ylabel('Beta (\beta)')
    cb = colorbar()
    cb.Label.String = 'NRMSD'
    cb.Label.FontSize = 20
    set(gca,'fontsize',20)
    savePDFfunction(fig1,[folder subFolder 'beta_vsf2Arr'])



    %%
    mrmsd = min(min(rmsd))
    elMR = find(rmsd == mrmsd)

    bA = length(betaA)*[1:length(f2Arr)]
    dbA = bA-elMR
    col1 = find((dbA<length(betaA)).*(dbA>0))
    row1 = elMR - (length(betaA)*(col1-1))

    beta = betaA(row1)
    f2Addon = f2Arr(col1)



    close all
    fig2 = figure
    h1 = plot(theta,yDat,'o-')

    f2 = minFt/abs(cosd(theta_minFt-beta))
    f2p = f2*abs(cosd(theta-beta))

    hold on
    h2 = plot(theta,f2p,'linewidth',2)
    hold on 

    f1 = f2*f2Addon;
    f1p = f1*abs(cosd(theta));
    ft = f1p + f2p;

    h3 = plot(theta,f1p,'b','linewidth',2);
    hold on
    h4 = plot(theta,ft,'k','linewidth',2);


    AR = max([f1/f2,f2/f1])
    beta = min([180-beta,beta])

    outX = [f1,f2,AR,beta,mrmsd]'


    grid on
    xlabel('Degrees')
    ylabel('Frequency')
    set(gca,'fontsize',20)
    legend([h1 h4 h3 h2],{'Data','Modelled total frequency',...
        'Modelled set 1 frequency','Modelled set 2 frequency'},...
        'location','southeast')
    title(['\beta = ' num2str(beta) '^{\circ}, A.R. = ' num2str(AR)...
        ', max/min frequency = ' num2str(max(yDat)/min(yDat)) ', and NRMSD = ' num2str(mrmsd)],'fontsize',16)
    savePDFfunction(fig2,[folder subFolder 'bestFitBeta'])




    cellRange = [cellN{1} '2:' cellN{1} '6']
    xlswrite('D:\Field_data\2013\Summer\Geotech\outcrop_disctontinuity.xlsx',outX,4,cellRange)    


end













