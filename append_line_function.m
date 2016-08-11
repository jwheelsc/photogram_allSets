function append_line_function(source, callbackdata)

[folder, subFolder, imgNum, setIn] = whatFolder()
folderStr = [folder subFolder setIn]
load(folderStr)

ind = source.Value   
h = imfreehand;
h0 = allSets{ind};
lin = h.getPosition;
if lin(1,1)>lin(end,1)
    lin = lin(end:-1:1,:);
end

d1 = sqrt(sum((h0(end,1)-lin(1,1)).^2+(h0(end,2)-lin(1,2)).^2));
d2 = sqrt(sum((h0(1,1)-lin(end,1)).^2+(h0(1,2)-lin(end,2)).^2));

if d1<d2
    allSets{ind} = [h0;lin];
else
    allSets{ind} = [lin;h0];
end

save(folderStr,'allSets','-append')

