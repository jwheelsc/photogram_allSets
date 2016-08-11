function draw_line_function(source, callbackdata)

[folder, subFolder, imgNum, setIn] = whatFolder()
folderStr = [folder subFolder setIn]
load(folderStr)

val = source.Value
source.String(val)
    count = 1
while count < 100
    h = imfreehand
    lin = h.getPosition
    if length(lin(:,1))==0
        return
    end
    if lin(1,1)>lin(end,1)
        lin = lin(end:-1:1,:)
    end
    %         lin = tooMuchCurvature(lin)
    allSets{end+1}= lin(:,:)
    save(folderStr,'allSets','-append')
    count = count+1    
end

