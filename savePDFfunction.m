function [] = savePDFfunction(fid, filename)

f1 = fid;

set(f1,'PaperOrientation','portrait');
set(f1,'PaperUnits','inches');
set(f1,'PaperPosition', [0 0 51 34]);
print(f1,filename,'-djpeg','-r100')

