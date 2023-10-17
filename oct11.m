%%  only table 
file_name = 'oct11/RigolDS0.csv'; 
data0 = readmatrix(file_name);
data = data0;
% 
parse_fname;
%  
CoDemOs;

%%  only table water flow off
file_name = 'oct11/RigolDS1.csv'; 
data1 = readmatrix(file_name);
data = data1;
% 
parse_fname;
%  
CoDemOs;


%%  only table water flow on green fom under the sensor
file_name = 'oct11/RigolDS2.csv'; 
data2 = readmatrix(file_name);
data = data2;
% 
parse_fname;
%  
CoDemOs;


%%  only table but 1 inch main mirror 
file_name = 'oct11/RigolDS3.csv'; 
data3 = readmatrix(file_name);
data = data3;
% 
parse_fname;
%  
CoDemOs;
