clear all
close all

[folder, subFolder, imgNum, setIn] = whatFolder()
folderStr = [folder subFolder setIn]

load(folderStr)

%% scale
findSF = 0
if findSF == 1
    load D:\Field_data\2013\Summer\Images\JWC\GL1\Photogrammetry\July17\GL1PG1ST1\IMG_9030_analysis\scales_3d.mat
    %%% these scales lengths were generated from plot_ptCloud, and notes are
    %%% therin

    for i = 1:length(s4)
        sb = s4{i} %%% here s4 are the scales drawn on the 2d image
        l_sb(i) = sqrt(sum((sb(2,:)-sb(1,:)).^2,2))
    end

    scale_factor = scales(:,2)./l_sb'  %% scales are the line length on the 3d images
    msf = mean(scale_factor)
end
msf = 1/108
%%
% thetaA = [5:5:175];
thetaA = [5:10:175];
jset = []

for ang = 1:length(thetaA)

    theta = num2str(thetaA(ang))

    np = []
    %%% this is a .mat file with a variable called set_int (joint set
    %%% intersection), which is a call array, and a variable containing line_length
    %%%. There is a cell for each
    %%% scanline, and within that cell contains the coordinates of where
    %%% the scanline of a given angle (theta) intersects a joint set (j)
    load([folder subFolder 'sl_pts_' num2str(theta) '_allSets.mat'])  ;
    t_dist_bwp = [];
    for i = 1:length(set_int)

        %%% in this section, i reorder the points to compute the spacing
        %%% between consecutive points
        if isempty(set_int{i})==0
            scat_jset = set_int{i};
            [dv,ia] = sort(scat_jset(:,1));
            jset = scat_jset(ia,:);
        end
        %%% then compute the distance between points
        dif1 = jset(2:end,:)-jset(1:end-1,:);
        dist_bwp = sqrt(sum(dif1.*dif1,2));
        %%% i create a massive cell where the distance between points is
        %%% appended onto the next scanline
        t_dist_bwp = [t_dist_bwp;dist_bwp];
        %%% here are the number of points for th egiven scanline
        np(i) = length(set_int{i});

    end

    % and here I have to scale it
    t_dist_bwp1 = t_dist_bwp*msf;
    %%% compute a few stats
    spc_mean = mean(t_dist_bwp1);
    spc_std = std(t_dist_bwp1);
    %%% here im saying that the frequncy is the inverse of the mean
    %%% spacing
    fq(ang) = 1/spc_mean;
    %%% alternatively, we can compute a frequency based on the mean of the
    %%% number of points for a given line length (scaled)
    m_fq(ang) = mean(np./(line_length*msf));


end

mean_fq = mean(m_fq)

fs2 = 12
f1 = figure(1)
    h1 = plot(thetaA,m_fq,'r-o')
        my = max(m_fq)
        el = find(m_fq==my)
        mx = thetaA(el)
        text(mx,my,num2str(my),'fontsize',fs2)
        
        my = min(m_fq)
        el = find(m_fq==my)
        mx = thetaA(el)
        text(mx,my,num2str(my),'fontsize',fs2)
    hold on
    h1a = plot(thetaA,fq,'r--o')
%         my = max(fq)
%         el = find(fq==my)
%         mx = thetaA(el)
%         text(mx,my,num2str(my),'fontsize',fs2)
    
    text(0.7,0.1,['mean = ' num2str(mean_fq)],'units','normalized','fontsize',12)
    ylabel('Joint frequency (\lambda)')
    xlabel('Scanline angle (\theta)')
    set(gca,'fontsize',16)
    grid on
    legend([h1 h1a], {'mean spacing^{-1}','total points per line'},...
        'location','northwest','fontsize',12)
    
%     savePDFfunction(f1,[folder 'figuresfrequency_angle'])
    
