function draw_line_function(source, callbackdata)
%DRAW_LINE_FUNCTION Summary of this function goes here
%   Detailed explanation goes here

[folder, subFolder, imgNum, setIn] = whatFolder()
folderStr = [folder subFolder setIn]
load(folderStr)

val = source.Value
source.String(val)
if strcmp(source.String(val),'create line')
    count = 1
    while count < 100
        h = imfreehand
        lin = h.getPosition
        if length(lin(:,1))==0
            return
        end
%         lin = tooMuchCurvature(lin)
        allSets{end+1}= lin(:,:)
        save(folderStr,'allSets','-append')
        count = count+1    
    end
end   

if strcmp(source.String(val),'append line, sort x')
    h = imfreehand
    h0 = s1{end}
    lin = h.getPosition
    hArr = [h0;lin(1:end)]
    [dv,ia] = sort(hArr(:,1))
    allSets{end} = hArr(ia,:)
    save(folderStr,'allSets','-append')
end

if strcmp(source.String(val),'append line, sort y')
    h = imfreehand
    h0 = s1{end}
    lin = h.getPosition
    hArr = [h0;lin(1:end,:)]
    [dv,ia] = sort(hArr(:,2))
    allSets{end} = hArr(ia,:)
    save(folderStr,'allSets','-append')
end

if strcmp(source.String(val),'redo line')
    h = imfreehand
    lin = h.getPosition
    allSets{end}= lin(:,:)
    save(folderStr,'allSets','-append')
end 

if strcmp(source.String(val),'draw set')
    run D:\Code\photogrammetry\allSets\draw_and_plot_Sets.m
end

end

