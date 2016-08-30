ds = getLineLength(allSets);

for i = 1:length(allSets)
    pp(i) = length(allSets{i})/ds(i);
end

close all
plot(pp)
hold on
plot(3,pp(3),'ro')

el1 = find(pp <0.15)
el2 = find(ds>1000)

smooth = intersect(el1,el2)