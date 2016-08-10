function redo_line_function(source, callbackdata)

[folder, subFolder, imgNum, setIn] = whatFolder()
folderStr = [folder subFolder setIn]
load(folderStr)

ind = source.Value  

h = imfreehand
lin = h.getPosition
if length(lin(:,1))==0
    return
end
%         lin = tooMuchCurvature(lin)
allSets{ind}= lin(:,:)
save(folderStr,'allSets','-append')

end

