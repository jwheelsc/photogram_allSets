clear variables

[dat, written] = xlsread('D:\Field_data\2013\Summer\Geotech\outcrop_disctontinuity.xlsx',1,'A1:AN102');
vars = written(:,1);
plotOn = logical(dat(strcmp(vars,'plot?'),:));

msLogi = dat(strcmp(vars,'rock type'),plotOn)== 1;
mxLogi = dat(strcmp(vars,'rock type'),plotOn)== 2;
stLogi = dat(strcmp(vars,'surge type'),plotOn)== 1;
ptLogi = dat(strcmp(vars,'rock type'),plotOn)== 3;
nstLogi = dat(strcmp(vars,'surge type'),plotOn)== 2;

glaciers = dat(strcmp(vars,'Glacier'),plotOn); 
labels = written(2,2:end);
labels = labels(plotOn)
maxFreq = dat(strcmp(vars,'max freq 40'),plotOn);
minFreq = dat(strcmp(vars,'min freq 40'),plotOn) ;
meanFreq = dat(strcmp(vars,'mean freq 40'),plotOn);
meanLgth = dat(strcmp(vars,'mean length'),plotOn);
stdLgth = dat(strcmp(vars,'std length'),plotOn);
numJnts = dat(strcmp(vars,'num joints'),plotOn);
totJntLength = dat(strcmp(vars,'total joint length'),plotOn);
numInts = dat(strcmp(vars,'intersections'),plotOn);
IntPA = dat(strcmp(vars,'intersectionsPerarea'),plotOn);
JntLgthPA = dat(strcmp(vars,'joint lengthPerarea'),plotOn);
JntsPA = dat(strcmp(vars,'jointsPerarea'),plotOn)
LX = dat(strcmp(vars,'length x (m)'),plotOn);
LY = dat(strcmp(vars,'length y (m)'),plotOn);
AR = dat(strcmp(vars,'area (m2)'),plotOn);
pxpm = dat(strcmp(vars,'scale factor (px/m)'),plotOn);
err = dat(strcmp(vars,'error m'),plotOn);
group_4 = dat(strcmp(vars,'group_4'),plotOn);
group_rk = dat(strcmp(vars,'group_rk'),plotOn);
l_d25 = dat(strcmp(vars,'l_d25'),plotOn);
l_d50 = dat(strcmp(vars,'l_d50'),plotOn);
l_d75 = dat(strcmp(vars,'l_d75'),plotOn);

%%% make some structure arrays

dataS = struct('glaciers',glaciers,'maxF',maxFreq,'minF',minFreq,'P10',meanFreq,'nJ',numJnts,...
    'tlJ',totJntLength,'nI',numInts,'I20',IntPA,'P21',JntLgthPA,'P20',JntsPA,'LX',LX,'LY',LY,...
    'AR',AR,'pxpm',pxpm,'err',err,'stdL',stdLgth,'mL',meanLgth,'ld25',l_d25,'ld50',l_d50,'ld75',l_d75)

% dataM = [dataS.P21',dataS.P20',dataS.P10',dataS.I20',dataS.mL']
dataM = [dataS.P21',dataS.P20',dataS.P10',dataS.I20']

logiS = struct('ms',msLogi,'mx',mxLogi,'pt',ptLogi,'st',stLogi,'nst',nstLogi)

plotLabs = {'P_{21} (m^{-1})','P_{20} (m^{-2})','P_{10} (m^{-1})','I_{20} (m^{-2})','L_{ave} (m)'}
% plotLabs_noU = {'P_{21}','P_{20}','P_{10}','I_{20}','L_{ave}'}
plotLabs_noU = {'P_{21}','P_{20}','P_{10}','I_{20}'}
return
