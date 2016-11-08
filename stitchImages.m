clear variables
clc
close all

folder = 'D:\Field_data\2013\Summer\Images\JWC\Aug01\GL5\Photogrammetry\GL5PG1ST1\'
files = ls([folder '*.jpg'])
files = cellstr(files)



for i = 1:length(files)
    f1 = figure
    imshow([folder files{i}])
    set(gca,'box','off')

    folderOut = [folder 'lowRes\' files{i}]
    set(f1,'PaperOrientation','portrait');
    set(f1,'PaperUnits','inches');
    set(f1,'PaperPosition', [0 0 51.84 34.56]);
    print(f1,folderOut,'-djpeg',['-r' num2str(25)])
end
