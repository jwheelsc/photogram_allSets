% clear variables
% close all
% % 
% [folder, subFolder, imgNum, setIn, imSave, msfc, ws, ol] = whatFolder(i)
% folderStr = [folder subFolder setIn]
% load(folderStr)

close all

for i = 1:length(allSets)
% for i =282
    hold on
    p = allSets{i};
    ph(i)=plot(p(:,1)',p(:,2)','k','linewidth',1);
end
        
    

%% how much does a set intersect itself?
intPts = [];
for i1 = 1:length(allSets)-1
    j1 = allSets{i1};
    j1x = j1(:,1);
    j1y = j1(:,2);
    
    m1 = (j1y(2:end)-j1y(1:end-1))./((j1x(2:end)-j1x(1:end-1)));
    m1(isinf(m1)) = 1e3;
    m1(isnan(m1)) = 0;
    b1 = j1y(2:end)-(j1x(2:end).*m1);
    l1 = length(b1);

    for i2 = i1+1:length(allSets)
        j2 = allSets{i2};
        j2x = j2(:,1);
        j2y = j2(:,2);   
        
        m2 = (j2y(2:end)-j2y(1:end-1))./((j2x(2:end)-j2x(1:end-1)));
        m2(isinf(m2)) = 1e3;
        m2(isnan(m2)) = 0;
        b2 = j2y(2:end)-(j2x(2:end).*m2);
        l2 = length(b2);
        
        
        m1m = repmat(m1,[1,l2]);
        b1m = repmat(b1,[1,l2]);
        
        x1l = repmat(j1x(1:end-1),[1,l2]);
        x1u = repmat(j1x(2:end),[1,l2]);
        y1l = repmat(j1y(1:end-1),[1,l2]);
        y1u = repmat(j1y(2:end),[1,l2]);
        
        
        
        m2m = repmat(m2',[l1,1]);
        b2m = repmat(b2',[l1,1]);
        
        x2l = repmat([j2x(1:end-1)]',[l1,1]);
        x2u = repmat([j2x(2:end)]',[l1,1]);
        y2l = repmat([j2y(1:end-1)]',[l1,1]);
        y2u = repmat([j2y(2:end)]',[l1,1]);
        
        
        
        xi = (b2m-b1m)./(m1m-m2m);
        yi = m2m.*xi+b2m;

        dM1l = sqrt((xi-x1l).^2+(yi-y1l).^2);
        dM1u = sqrt((xi-x1u).^2+(yi-y1u).^2);
        dM1t = sqrt((x1l-x1u).^2+(y1l-y1u).^2);
        
        dM2l = sqrt((xi-x2l).^2+(yi-y2l).^2);
        dM2u = sqrt((xi-x2u).^2+(yi-y2u).^2);
        dM2t = sqrt((x2l-x2u).^2+(y2l-y2u).^2);
        
        elL = dM1l<dM1t;
        e1U = dM1u<dM1t;
        logi1 = logical(elL.*e1U);
        
        e2L = dM2l<dM2t;
        e2U = dM2u<dM2t;
        logi2 = logical(e2L.*e2U);
        
        logiT = logical(logi1.*logi2);
        xI = xi(logiT);
        yI = yi(logiT);
        if isempty(xI)==0
            xI = xI(1);
            yI = yI(1);
        end
        
        intPts = [intPts;[xI,yI]];
        
        
    end
    i1
end

hold on
plot(intPts(:,1),intPts(:,2),'b.','markersize',10)
f1 = gcf
savePDFfunction(f1,[folder subFolder 'intersect' imSave])
totalints = length(intPts(:,1))
save([folder subFolder 'results_intersections.mat'],'totalints')
    
%     
%         
%         for i2a = 1:length(j2x)-1
%             m2 = (j2y(i2a+1)-j2y(i2a))./(j2x(i2a+1)-j2x(i2a));
%             m2(isinf(m2)) = 1e3;
%             m2(isnan(m2)) = 0;
%             b2 = j2y(i2a+1)-(j2x(i2a+1).*m2);
%             xi = (b2-b1)./(m1-m2);
%             yi = m2.*(xi+b2);
%             
%             d1a = sqrt((xi-j1x(1:end-1)).^2+(yi-j1y(1:end-1)).^2);
%             d1b = sqrt(((xi-j1x(2:end)).^2)+((yi-j1y(2:end)).^2));
%             d1 = sqrt(((j1x(1:end-1)-j1x(2:end)).^2)+((j1y(1:end-1)-j1y(2:end)).^2)); 
%             inBox1 = logical((d1a<d1).*(d1b<d1))
%             
%             d2a = sqrt(((xi-j2x(i2a+1)).^2)+((yi-j2y(i2a+1)).^2));
%             d2b = sqrt(((xi-j2x(i2a)).^2)+((yi-j2y(i2a)).^2));
%             d2 = sqrt(((j2x(i2a+1)-j2x(i2a)).^2)+((j2y(i2a+1)-j2y(i2a)).^2)); 
%             inBox2 = logical((d2a<d2).*(d2b<d2))
%             inBox = logical(inBox1.*inBox2);
%             keyboard
%             if sum(inBox)>=1
%                 intPts = [intPts;[xi(inBox),yi(inBox)]];
%                 keyboard
%             end
%                               
%             
%         end
%               
%     end
%     
%     i1
% % end
% 
% hold on 
% plot(intPts(:,1),intPts(:,2),'bo')
% 
% return
% %%
% intPts = []
% count = 1
% for i = 1:length(allSets)-1
%     
%     j1 = allSets{i};
%     for j = i+1:length(allSets)
%     
%        j2 = allSets{j};
%         
%        jp1x = repmat(j1(:,1),[1,length(j2(:,1))])';
%        jp2x = repmat(j2(:,1),[1,length(j1(:,1))]);  
%        jp1y = repmat(j1(:,2),[1,length(j2(:,2))])';
%        jp2y = repmat(j2(:,2),[1,length(j1(:,2))]);  
% 
%        dM = sqrt((jp2x-jp1x).^2+(jp2y-jp1y).^2);
%        
%        mdM = min(min(dM));
%        [row,col] = find(abs(dM-mdM)<1e-3);
%        row = row(end);
%        col = col(end);
%        if mdM < critical_d
%            intPts(count,:) = j1(col,:);
%            count = count+1;
%        end
%        
%     end
%     
% end
% 
% save([folder subFolder 'setInt.mat'],'intPts')
% totalints = length(intPts)
% 
% 
% %%
% load([folder subFolder 'setInt.mat'])
% hold on
% plot(intPts(:,1),intPts(:,2),'o')
% 
% f1 = gcf
% savePDFfunction(f1,[folder subFolder 'intersect' imSave])
% save([folder subFolder 'results_intersections.mat'],'totalints')
% 














