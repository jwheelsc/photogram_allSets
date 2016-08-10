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

if strcmp(source.String(val),'append line')
    
    gip = ginput(2)
    
    pl1 = gip(1,:);
    count = 1;
    for i = 1:length(allSets)
      p = allSets{i};
      for j = 1:length(p)
            pr = p-pl1;
            elx = find(abs(pr(:,1))<2)
            ely = find(abs(pr(:,2))<2)
            if isempty(elx) == 0 && isempty(ely) == 0
            	pl1A(count) = i
                count = count+1
                break
          end
      end
    end
    
    pl1 = gip(2,:);
    count = 1;
    for i = 1:length(allSets)
      p = allSets{i};
      for j = 1:length(p)
            pr = p-pl1;
            elx = find(abs(pr(:,1))<2)
            ely = find(abs(pr(:,2))<2)
            if isempty(elx) == 0 && isempty(ely) == 0
            	pl1B(count) = i
                count = count+1
            break
          end
      end
    end
    
    ind = intersect(pl1A,pl1B)
    
    h = imfreehand
    h0 = allSets{ind}
    lin = h.getPosition
    
    d1 = sqrt(sum((h0(1,end)-lin(1,1)).^2+(h0(2,end)-lin(2,1)).^2))
    d2 = sqrt(sum((h0(1,1)-lin(1,end)).^2+(h0(2,1)-lin(2,end)).^2))
    
    if d1>d2
        allSets{ind} = [h0;lin]
    else
        allSets{ind} = [lin;h0]
    end
    
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
