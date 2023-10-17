% sep 25
file_name = 'sep21/RigolDS3.csv';
data1 = readmatrix(file_name);

slash_i = strfind(file_name,'/');

mo = file_name(1:3);
if mo == 'sep'
    mnth = 9;
elseif mo == 'oct'
    mnth = 10;
elseif mo == 'nov'
    mnth = 11;
else
    mo = 0;
end
day = str2num(file_name(4:slash_i-1));


exp_ind = strfind(file_name,'DS');
exp_number = str2num(file_name(14:end-4));

plot_index = mnth*10^7 + day*10^5 + exp_ind*10^2;
%%
CoDemOs;