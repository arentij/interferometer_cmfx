%%
% all_day_data_array ={};
%% this day is just a lot of through chamber shots without plasma to try averaging protocol
file_name = 'dec11/RigolDS0.csv';
data0 = readmatrix(file_name);
data = data0(:,1);
% 
parse_fname;
%  
CoDemOs;

%%
file_name = 'dec11/RigolDS1.csv';
data0 = readmatrix(file_name);
data = data0(:,1);
% 
parse_fname;
%  
CoDemOs;

%%
file_name = 'dec11/RigolDS2.csv';
data0 = readmatrix(file_name);
data = data0(:,1);
% 
parse_fname;
%  
CoDemOs;


%%
file_name = 'dec11/RigolDS3.csv';
data0 = readmatrix(file_name);
data = data0(:,1);
% 
parse_fname;
%  
CoDemOs;


%%
file_name = 'dec11/RigolDS4.csv';
data0 = readmatrix(file_name);
data = data0(:,1);
% 
parse_fname;
%  
CoDemOs;
%%
save('all_day_data_231211.mat',"all_day_data_array");

%% might be nasty
file_name = 'dec11/RigolDS5.csv';
data0 = readmatrix(file_name);
data = data0(:,1);
% 
parse_fname;
%  
CoDemOs;

%%
file_name = 'dec11/RigolDS6.csv';
data0 = readmatrix(file_name);
data = data0(:,1);
% 
parse_fname;
%  
CoDemOs;

%%
file_name = 'dec11/RigolDS7.csv';
data0 = readmatrix(file_name);
data = data0(:,1);
% 
parse_fname;
%  
CoDemOs;


%% might be also nasty
file_name = 'dec11/RigolDS8.csv';
data0 = readmatrix(file_name);
data = data0(:,1);
% 


parse_fname;
%  
CoDemOs;

%% maybe nasty'ish
file_name = 'dec11/RigolDS9.csv';
data0 = readmatrix(file_name);
data = data0(:,1);
% 
parse_fname;
%  
CoDemOs;

%%
file_name = 'dec11/RigolDS10.csv';
data0 = readmatrix(file_name);
data = data0(:,1);
% 
parse_fname;
%  
CoDemOs;

%%
file_name = 'dec11/RigolDS11.csv';
data0 = readmatrix(file_name);
data = data0(:,1);
% 
parse_fname;
%  
CoDemOs;
%%
save('all_day_data_231211.mat',"all_day_data_array", '-v7.3');

%%
file_name = 'dec11/RigolDS12.csv';
data0 = readmatrix(file_name);
data = data0(:,1);
% 
parse_fname;
%  
CoDemOs;


%%
file_name = 'dec11/RigolDS13.csv';
data0 = readmatrix(file_name);
data = data0(:,1);
% 
parse_fname;
%  
CoDemOs;

%%
file_name = 'dec11/RigolDS14.csv';
data0 = readmatrix(file_name);
data = data0(:,1);
% 
parse_fname;
%  
CoDemOs;

%
file_name = 'dec11/RigolDS15.csv';
data0 = readmatrix(file_name);
data = data0(:,1);
% 
parse_fname;
%  
CoDemOs;

%
file_name = 'dec11/RigolDS16.csv';
data0 = readmatrix(file_name);
data = data0(:,1);
% 
parse_fname;
%  
CoDemOs;

%%
save('all_day_data_231211.mat',"all_day_data_array", '-v7.3');
%%
file_name = 'dec11/RigolDS17.csv';
data0 = readmatrix(file_name);
data = data0(:,1);
% 
parse_fname;
%  
CoDemOs;

%
file_name = 'dec11/RigolDS18.csv';
data0 = readmatrix(file_name);
data = data0(:,1);
% 
parse_fname;
%  
CoDemOs;

%
file_name = 'dec11/RigolDS19.csv';
data0 = readmatrix(file_name);
data = data0(:,1);
% 
parse_fname;
%  
CoDemOs;
%%
save('all_day_data_231211.mat',"all_day_data_array", '-v7.3');

%%
%
file_name = 'dec11/RigolDS20.csv';
data0 = readmatrix(file_name);
data = data0(:,1);
% 
parse_fname;
%  
CoDemOs;

%
file_name = 'dec11/RigolDS21.csv';
data0 = readmatrix(file_name);
data = data0(:,1);
% 
parse_fname;
%  
CoDemOs;

%
file_name = 'dec11/RigolDS22.csv';
data0 = readmatrix(file_name);
data = data0(:,1);
% 
parse_fname;
%  
CoDemOs;


%%
file_name = 'dec11/RigolDS23.csv';
data0 = readmatrix(file_name);
data = data0(:,1);
% 
parse_fname;
%  
CoDemOs;

%
file_name = 'dec11/RigolDS24.csv';
data0 = readmatrix(file_name);
data = data0(:,1);
% 
parse_fname;
%  
CoDemOs;

%
save('all_day_data_231211.mat',"all_day_data_array", '-v7.3');
%%

fileID = fopen('dec11/RigolDS0.bin');
A = fread(fileID);
fclose(fileID);
%%
whos A

%%
A(1:200)