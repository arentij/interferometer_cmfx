file_name = 'dec01/RigolDS1.csv';
data0 = readmatrix(file_name);
%%
figure(800);
dta =  data0(:,1);

driv = data0(:,2);

clf
hold on
plot(dta(1+4:1000),dta(1:1000-4))
plot(driv(1+4:1000),driv(1:1000-4))
