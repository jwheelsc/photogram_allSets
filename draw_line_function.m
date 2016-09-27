function draw_line_function(source, callbackdata)

iNum = source.UserData.imNum;
[folder, subFolder, imgNum, setIn, imSave, msfc, ws, ol] = whatFolder(iNum);
folderStr = [folder subFolder setIn];
load(folderStr);

folderStr2 = [folder subFolder 'looping.mat']
loops = 'yes'
save(folderStr2,'loops')

val = source.Value;
source.String(val);
    count = 1;
while count < 100
    
    load([folder subFolder 'looping.mat'])
    
    if strcmp(loops,'yes')
        h = imfreehand;
        lin = h.getPosition;
    end
    if strcmp(loops,'no')
        lin = [0,0]
    end
    
    if length(lin(:,1))<2
        return
    end
    if lin(1,1)>lin(end,1)
        lin = lin(end:-1:1,:);
    end
    %         lin = tooMuchCurvature(lin)
    allSets{end+1}= lin(:,:);
    save(folderStr,'allSets','-append');
    count = count+1; 
    
    load([folder subFolder 'looping.mat'])
    
end

