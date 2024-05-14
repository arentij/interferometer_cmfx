%%
file_name = 'dec13/RigolDS0.csv';
data0 = readmatrix(file_name);
data = data0(:,1);
% 
parse_fname;
%  
CoDemOs;
%%
figure(111);
clf
hold on
plot(data0(:,1))
plot(data0(:,2))
%%

%%
file_name = 'dec13/RigolDS1.csv';
data0 = readmatrix(file_name);
data = data0(:,1);
% 
parse_fname;
%  
CoDemOs;
%%
figure(111);
clf
hold on
sig = data0(:,1);
driv  = data0(:,2);
sig = sig - movmean(sig,fix(12.5*100));
driv = driv - movmean(driv,fix(12.5*100));
t_plt = [1:1000];
dt = 11;
data_t_plt = sig(t_plt) - driv(t_plt+dt);
plot(sig(t_plt))
plot(driv(t_plt+dt))
% plot(data_t_plt,'LineWidth',2,'LineStyle','--')


%% this one is screwed 
file_name = 'dec13/RigolDS2.csv';
data0 = readmatrix(file_name);
data = data0(:,1);
% 
parse_fname;
%  
CoDemOs;

%%
file_name = 'dec13/RigolDS3.csv';
data0 = readmatrix(file_name);
data = data0(:,1);
% 
parse_fname;
%  
CoDemOs;


%%
file_name = 'dec13/RigolDS4.csv';
data0 = readmatrix(file_name);
data = data0(:,1);
% 
parse_fname;
%  
% CoDemOs;
%%
figure(1234)
plot(data0(1:100,2))


%%
file_name = 'dec13/RigolDS5.csv';
data0 = readmatrix(file_name);
data = data0(:,1);
% 
parse_fname;
%  
CoDemOs;
