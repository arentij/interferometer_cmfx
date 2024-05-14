slash_i = strfind(file_name,'/');

mo = file_name(1:3);
if mo == 'sep'
    mnth = 9;
    year = 23;
elseif mo == 'oct'
    mnth = 10;
    year = 23;
elseif mo == 'nov'
    mnth = 11;
    year = 23;
elseif mo =='dec'
    mnth = 12;
    year = 23;
elseif mo =='jan'
    mnth = 1;
    year = 24;
elseif mo =='feb'
    mnth = 2;
    year = 24;
elseif mo =='mar'
    mnth = 3;
    year = 24;
else
    mo = 0;
    year = 23;
end
day = str2num(file_name(4:slash_i-1));


exp_ind = strfind(file_name,'CMFX_');
exp_number = str2double(file_name(exp_ind+6:exp_ind+9));

plot_index =(year-23)*10^9 + mnth*10^7 + day*10^5 + exp_number*10^0;




