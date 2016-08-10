function append_line_function(source, callbackdata)

[folder, subFolder, imgNum, setIn] = whatFolder()
folderStr = [folder subFolder setIn]
load(folderStr)

ind = source.Value   
h = imfreehand;
h0 = allSets{ind};
lin = h.getPosition;

d1 = sqrt(sum((h0(1,end)-lin(1,1)).^2+(h0(2,end)-lin(2,1)).^2));
d2 = sqrt(sum((h0(1,1)-lin(1,end)).^2+(h0(2,1)-lin(2,end)).^2));

if d1<d2
    allSets{ind} = [h0(1:end-5,:);lin];
else
    allSets{ind} = [lin;h0(5:end,:)];
end

save(folderStr,'allSets','-append')
