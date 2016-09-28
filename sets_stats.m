% clear all
close all
% 
% [folder, subFolder, imgNum, seIn, imSave, msfc, ws, ol] = whatFolder()
% folderStr = [folder subFolder setIn]
% 
% load(folderStr)

%% this section is to get the distriubtion of lengths of all the sets, and the first two section of this script should first be run


close all
fL = figure;
bins = 60;
fs = 16;

    
SN = allSets;
    
for i = 1:length(SN)
    lin = SN{i};
    diff = lin(2:end,:)-lin(1:end-1,:);
    d(i) = sum(sqrt((diff(:,1).^2)+(diff(:,2).^2)));
end
d_sc1 = d*msfc;
h = histogram(d_sc1,bins,'normalization','pdf');
%     keyboard
text(0.5,0.7,['mean = ' num2str(mean(d_sc1)) 'm'],'units','normalized','fontsize',fs)
%     text(0.5,0.6,['mode = ' num2str(mode(d_sc1)) 'm'],'units','normalized','fontsize',fs)
grid on
xlabel('trace length (m)','fontsize',fs)
ylabel(['probability'],'fontsize',fs)
xlim([0 2]);
xl = get(gca,'xlim');
mean_l = mean(d_sc1(d_sc1>0));
std_l = std(d_sc1(d_sc1>0));
lambda = mean_l^-1;
xx = linspace(xl(1),xl(2),100);
yy = lambda*exp(-lambda*xx);
hold on 
h1 = plot(xx,yy,'r','linewidth',2);
lambdahat = lognfit(d_sc1(d_sc1>0));
yy2 = lognpdf(xx,lambdahat(1),lambdahat(2));
hold on
h2 = plot(xx,yy2,'b','linewidth',2);
set(gca,'fontsize',fs)
hold on
plot([mean_l mean_l],get(gca,'ylim'),'k')
legend([h1 h2], {'negative exponential','lognormal'},'location','northeast','fontsize',12)

savePDFfunction(fL,[folder subFolder 'dist' imSave])
%% this is a section to get the total length of a joint set and the number of joints, run the first two sections
SN = allSets;
for i = 1:length(SN)
    lin = SN{i};
    diff = lin(2:end,:)-lin(1:end-1,:);
    d(i) = sum(sqrt((diff(:,1).^2)+(diff(:,2).^2)));
end
sum_length = sum(d*msfc);
num_joints = length(SN); 
save([folder subFolder 'results.mat'],'mean_l','std_l','sum_length','num_joints','-append')

    
    

