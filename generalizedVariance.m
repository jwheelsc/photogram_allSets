function [S] = generalizedVariance(dat)

n = length(dat(:,1));
meanDat = mean(dat);

S = [];
for i = 1:length(dat(1,:))
    for j = 1:length(dat(1,:)) 
        S(i,j) = (1/(n-1))*sum((dat(:,i)-meanDat(i)).*(dat(:,j)-meanDat(j)));
    end
end