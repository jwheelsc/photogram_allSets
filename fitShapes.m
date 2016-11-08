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

% for iii = 1:length(iA)


diffAi = [60:5:110]
diffAi = 85
for dI = 1:length(diffAi)
        matchD = 1

figure
% for iii = 1:length(glLabsA)
iii = find(strcmp(glLabsA,'7'))
 
    ii = iA(iii)
    cellN = cellNA(iii)
    [folder, subFolder, imgNum, setIn, imSave, msfc, ws, ol] = whatFolder(ii)
    folderStr = [folder subFolder setIn]
    load(folderStr)    

    cellRange = [cellN{1} num2str(elGt)  ':' cellN{1} num2str(elGt)]
    glType = xlsread('D:\Field_data\2013\Summer\Geotech\outcrop_disctontinuity.xlsx',1,cellRange)
    data = load([folder subFolder 'results_' hS '.mat'])
    minEl = find(data.fq == min(data.fq))

    x = data.thetaA
%     a = [[minEl:length(x)],[1:minEl-1]]
%     y = data.fq(a)
    y = data.fq

    if glType == 1
       mc = [1 0 0]
    elseif glType ==2 
       mc = [0 0 1]
    end

%     close all
%     figure()

% Aarr = max(data.fq)/min(data.fq)
maxEl = find(data.fq == max(data.fq))
% close all
figure
% y = y(end:-1:1)
plot(x,y,'r+-')
% hold on
% plot(x+180,y,'m+-')

% return
%% here where you can move the data around and explore the data
% y = data.fq
osd = 75
firstEl = abs(x(find(y==min(y)))-osd)
% firstEl = 121

    close all
    diffA = diffAi(dI)

    beta = diffA
    slos = osd-diffA
    el1 = find(data.thetaA == firstEl+slos)
    el2 = find(data.thetaA == 176)
    el3 = find(data.thetaA == 1)
    el4 = find(data.thetaA == firstEl-5+slos)

    el = [[el1:el2],[el3:el4]]


%     y = y(end:-1:1)
    y = y(el)

    fig1 = figure(1)
    h1 = plot([1:5:176],y,'o-','color',[0 0.4470 0.7410])
    grid on
%     return

    %%

    theta = data.thetaA(1:find(data.thetaA==176))
    f = y

    d2M = zeros(length(theta),length(theta));
    d1M = zeros(length(theta),length(theta));

    lt90 = sum(theta<90)
    gt90 = sum(theta>90)

    alpha_1 = abs(theta-[zeros(1,lt90),ones(1,gt90)*180])

    beta_el = max((theta<=beta).*[1:length(theta)])
    beta_el90 = max((theta<=(beta+90)).*[1:length(theta)])
    alpha_2_1 =  [ones(1,beta_el),-ones(1,beta_el90-(beta_el)),ones(1,length(theta)-(beta_el90))]
    alpha_2_90s = [ones(1,beta_el)*0,ones(1,beta_el90-(beta_el))*0,ones(1,length(theta)-(beta_el90))*180]

    alpha_2 = alpha_2_90s + ((beta-theta).*alpha_2_1)

    for i = 2:length(theta)-2
        for j = i+1:length(theta)-1
            ind1 = i;
            ind2 = j;
            s1 = theta(ind1);
            s2 = theta(ind2);
            beta = diffA;

            a1 = alpha_1(ind1);
            a2 = alpha_2(ind1);
            a1p = alpha_1(ind2);
            a2p = alpha_2(ind2);

            c1 = f(ind2);
            c2 = f(ind1)*sind(a1p);
            c3 = sind(a2)*sind(a1p);
            c4 = sind(a2p)*sind(a1);
            c5 = sind(a1);

            d2 = (c4-c3)/((c1*c5)-c2);
            d1 = sind(a1)/(f(ind1)-(sind(a2)/d2));
            d2M(i,j) = d2;
            d1M(i,j) = d1;
        end
    end

    figure(2)
    plot(d1M(d1M~=0),d2M(d2M~=0),'.')

    d1t = nanmean(d1M(d1M~=0))
    d2t = nanmean(d2M(d2M~=0))


    %% here you can use the analytical method of solving for f
    if matchD == 1
        d1 = d1t
        d2 = d2t
    elseif matchD ==2
        d1 = d2t
        d2 = d1t
    end


    alpha_1 = abs(theta-[zeros(1,lt90),ones(1,gt90)*180])


    beta_el = max((theta<=beta).*[1:length(theta)])
    beta_el90 = max((theta<=(beta+90)).*[1:length(theta)])
    alpha_2_1 =  [ones(1,beta_el),-ones(1,beta_el90-(beta_el)),ones(1,length(theta)-(beta_el90))]
    alpha_2_90s = [ones(1,beta_el)*0,ones(1,beta_el90-(beta_el))*0,ones(1,length(theta)-(beta_el90))*180]

    alpha_2 = alpha_2_90s + ((beta-theta).*alpha_2_1)

    figure(1)
    hold on
    f = sind(alpha_1)./d1 + sind(alpha_2)./d2
    h2 = plot(theta,f,'k-','linewidth',2)
    hold on
    f1 = sind(alpha_1)./d1
    h3 = plot(theta,f1,'color', [0.8500 0.3250 0.0980],'linewidth',2)
    hold on
    f2 = sind(alpha_2)./d2
    h4 = plot(theta,f2,'b','linewidth',2)
    grid on

    ylabel('Frequency (m^{-1})')
    xlabel('Degrees')
    ylm1 = get(gca,'ylim')
    xlm1 = get(gca,'xlim')
    rmsd = sqrt(sum(((f-y)/mean(y)).^2))
    % text(xlm1(2)*1/6,ylm1(2)*4/5,['rmsd = ' num2str(rmsd)],'fontsize',18)
    % text(xlm1(2)*1/6,ylm1(2)*4.2/5,['beta = ' num2str(beta)],'fontsize',18)
    
%     ' for beta = ' num2str(beta) '_' num2str(matchD)])
    set(gca,'fontsize',20)
    title(['\beta = 85^o, A.R. = 1.44, max/min frequency = 1.3706, NRMSD = ' num2str(rmsd)],'fontsize',16)
    ylim([0 10])
    
    figure(1)
%     legend([h1 h2 h3 h4],{'data','modelled total','modelled set 1','modelled set 2'},'location','southeast')
    savePDFfunction(fig1,[folder subFolder 'shapeFit_' num2str(beta) '_' num2str(matchD)])

    shapeOut = [d1t,d2t,rmsd]'
end
return
%     
% if matchD == 1    
%     if beta == 60
%         cellRange = [cellN{1} '9:' cellN{1} '11']
%         xlswrite('D:\Field_data\2013\Summer\Geotech\outcrop_disctontinuity.xlsx',shapeOut,3,cellRange)    
%     elseif beta == 65
%         cellRange = [cellN{1} '14:' cellN{1} '16']
%         xlswrite('D:\Field_data\2013\Summer\Geotech\outcrop_disctontinuity.xlsx',shapeOut,3,cellRange)   
%     elseif beta == 70
%         cellRange = [cellN{1} '19:' cellN{1} '21']
%         xlswrite('D:\Field_data\2013\Summer\Geotech\outcrop_disctontinuity.xlsx',shapeOut,3,cellRange)    
%     elseif beta == 75
%         cellRange = [cellN{1} '24:' cellN{1} '26']
%         xlswrite('D:\Field_data\2013\Summer\Geotech\outcrop_disctontinuity.xlsx',shapeOut,3,cellRange)
%     elseif beta == 80
%         cellRange = [cellN{1} '29:' cellN{1} '31']
%         xlswrite('D:\Field_data\2013\Summer\Geotech\outcrop_disctontinuity.xlsx',shapeOut,3,cellRange)    
%     elseif beta == 85
%         cellRange = [cellN{1} '34:' cellN{1} '36']
%         xlswrite('D:\Field_data\2013\Summer\Geotech\outcrop_disctontinuity.xlsx',shapeOut,3,cellRange)    
%     elseif beta == 90
%         cellRange = [cellN{1} '39:' cellN{1} '41']
%         xlswrite('D:\Field_data\2013\Summer\Geotech\outcrop_disctontinuity.xlsx',shapeOut,3,cellRange)    
%     elseif beta == 95
%         cellRange = [cellN{1} '44:' cellN{1} '46']
%         xlswrite('D:\Field_data\2013\Summer\Geotech\outcrop_disctontinuity.xlsx',shapeOut,3,cellRange)    
%     elseif beta == 100
%         cellRange = [cellN{1} '49:' cellN{1} '51']
%         xlswrite('D:\Field_data\2013\Summer\Geotech\outcrop_disctontinuity.xlsx',shapeOut,3,cellRange)   
%     elseif beta == 105
%         cellRange = [cellN{1} '54:' cellN{1} '56']
%         xlswrite('D:\Field_data\2013\Summer\Geotech\outcrop_disctontinuity.xlsx',shapeOut,3,cellRange)   
%     end
% end
% 
%     
% if matchD == 2    
%     if beta == 60
%         cellRange = [cellN{1} '60:' cellN{1} '62']
%         xlswrite('D:\Field_data\2013\Summer\Geotech\outcrop_disctontinuity.xlsx',shapeOut,3,cellRange)    
%     elseif beta == 65
%         cellRange = [cellN{1} '65:' cellN{1} '67']
%         xlswrite('D:\Field_data\2013\Summer\Geotech\outcrop_disctontinuity.xlsx',shapeOut,3,cellRange)   
%     elseif beta == 70
%         cellRange = [cellN{1} '70:' cellN{1} '72']
%         xlswrite('D:\Field_data\2013\Summer\Geotech\outcrop_disctontinuity.xlsx',shapeOut,3,cellRange)    
%     elseif beta == 75
%         cellRange = [cellN{1} '75:' cellN{1} '77']
%         xlswrite('D:\Field_data\2013\Summer\Geotech\outcrop_disctontinuity.xlsx',shapeOut,3,cellRange)
%     elseif beta == 80
%         cellRange = [cellN{1} '80:' cellN{1} '82']
%         xlswrite('D:\Field_data\2013\Summer\Geotech\outcrop_disctontinuity.xlsx',shapeOut,3,cellRange)    
%     elseif beta == 85
%         cellRange = [cellN{1} '85:' cellN{1} '87']
%         xlswrite('D:\Field_data\2013\Summer\Geotech\outcrop_disctontinuity.xlsx',shapeOut,3,cellRange)    
%     elseif beta == 90
%         cellRange = [cellN{1} '90:' cellN{1} '92']
%         xlswrite('D:\Field_data\2013\Summer\Geotech\outcrop_disctontinuity.xlsx',shapeOut,3,cellRange)    
%     elseif beta == 95
%         cellRange = [cellN{1} '95:' cellN{1} '97']
%         xlswrite('D:\Field_data\2013\Summer\Geotech\outcrop_disctontinuity.xlsx',shapeOut,3,cellRange)    
%     elseif beta == 100
%         cellRange = [cellN{1} '100:' cellN{1} '100']
%         xlswrite('D:\Field_data\2013\Summer\Geotech\outcrop_disctontinuity.xlsx',shapeOut,3,cellRange)   
%     elseif beta == 105
%         cellRange = [cellN{1} '105:' cellN{1} '105']
%         xlswrite('D:\Field_data\2013\Summer\Geotech\outcrop_disctontinuity.xlsx',shapeOut,3,cellRange)   
%     end
% end
%     
% end
% 
% 

