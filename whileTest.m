clear variables

iNum = 17
[folder, subFolder, imgNum, setIn, imSave, msfc, ws, ol] = whatFolder(iNum)
folderStr = [folder subFolder setIn]

close all
f1 = figure('units','normalized','outerposition',[0 0 1 1])
imshow([folder imgNum])


%%
i = 0
while(1) i< 10
    hi = imfreehand
    i = i+1
end

%%
while(2) j<10
    hj = imfreehand
    j = j+1
end