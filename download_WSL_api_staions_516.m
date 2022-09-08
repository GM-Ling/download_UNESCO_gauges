%download unesco word sea level api
%https://webcritech.jrc.ec.europa.eu/SeaLevelsDb
%https://webcritech.jrc.ec.europa.eu/SeaLevelsDb/api/Data/Get/2493?tMin=2021-07-14%2000:00:00&tMax=2021-07-20%2023:27:51&nRec=5000&mode=CSV
close all
clearvars;
clc
!rm *.csv

stations = load('unesco_gauges_ID.dat');


init = datetime('now');
backday=5;
TE = datestr(init,'yyyy-mm-dd HH:MM');           %precent date
TS = datestr(init - backday,'yyyy-mm-dd HH:MM'); %back to this date

%
str1='https://webcritech.jrc.ec.europa.eu/SeaLevelsDb/api/Data/Get/';
str2='?tMin=';
str3='%20';
str4='&tMax=';
str5='&nRec=5000&mode=CSV';
%
strs1=datestr(init - backday,'yyyy');
strs2=datestr(init - backday,'mm');
strs3=datestr(init - backday,'dd');
stre1=datestr(init,'yyyy');
stre2=datestr(init,'mm');
stre3=datestr(init,'dd');
stre4=datestr(init,'HH');
stre5=datestr(init,'MM');

nstn=length(stations);

shell='#!/bin/bash';
coms='wget -O ';
for i=1:nstn
    fid1 = fopen('download_WSL_api_address.sh','w');
    fprintf(fid1,'%s\n',shell);
    filename = [num2str(stations(i)) '_' num2str(strs1) num2str(strs2) num2str(strs3) '_' num2str(stre1) num2str(stre2) num2str(stre3) '_wse.csv '];
    
    fprintf(fid1,'%s',coms);
    fprintf(fid1,'%s',filename);
    staname=num2str(stations(i));
str_sta=['"',str1,staname,str2,strs1,'-',strs2,'-',strs3,str3,'00:00:00',str4,stre1,'-',stre2,'-',stre3,str3,stre4,':',stre5,':00',str5,'"'];
urls=join(str_sta);
fprintf(fid1,'%s\n',urls);
fclose(fid1);
!sh download_WSL_api_address.sh
% !wget -i download_wl_address.txt 

end