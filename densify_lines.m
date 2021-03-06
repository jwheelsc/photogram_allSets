%%% this function is called on from analyze_sets to densify the lines that
%%% were created using imfreehand

function [output] = densify_lines(jset,msfc)

% df = 20
% [folder, subFolder, imgNum, setIn, imSave, msfc, ws, ol] = whatFolder(iii)
% folderStr = [folder subFolder setIn]
% load(folderStr) 
% 
% for iii = 1:length(allSets)
% jset = allSets{iii}
% load(folderStr)
% % figure
% for kk = 926
% jset = allSets{kk}

jsetIn = jset;
%% in this section you can find the repeated values, and if they are at the end then cut it off
d_js = jset(2:end,1)-jset(1:end-1,1);
eld = length(jset(:,1)) - find(d_js<0); 
% keyboard
if sum(eld<5)>1
    jset = jset(1:end-7,:);
end
% if sum(eld>(length(jset(:,1))-5))>1
%     jset = jset(15:end,:)
% end

if length(jset(:,1))<2
    output = jsetIn;
    return    
end

yOut = [];
xOut = [];
for i = 1:length(jset)-1
    
    x = [jset(i,1),jset(i+1,1)];
    if x(1)==x(2)
        x(2) = x(2) + (rand(1)*(1e-4/msfc));
    end
    y = [jset(i,2),jset(i+1,2)];
    dP = sqrt((x(1)-x(2)).^2+(y(1)-y(2)).^2);
    dR = dP*msfc;
    df = dR/5e-3;
    xx = linspace(x(1),x(2),df);
    yy = interp1(x,y,xx);
    xOut = [xOut,xx];
    yOut = [yOut,yy];
%     keyboard

end


output = [xOut',yOut'];

% close all
% plot(jsetIn(:,1),jsetIn(:,2),'bo')
% hold on
% plot(xOut,yOut,'r+')
% keyboard
% end



