%%
file_name = 'nov27/RigolDS0.csv';
% data0 = readmatrix(file_name);
data = data0(:,1);
% 
parse_fname;
%  
CoDemOs;

%%
figure(80)
clf
hold on
f1 = scatter(data0(1:10000,1),data0(1:10000,2),100,'filled');
% plot(data0(1:1000,2))
% f1.MarkerSize = 100;
%%

figure(888)
t_ar = 0:2e-9:100e-3;
d_ar = sin(2*pi*40e6*t_ar)+1e-2*randn(size(t_ar));
ts = 40000000;
plot(driver(ts+1+3:ts+10000000),driver(ts+1:ts+10000000-3))