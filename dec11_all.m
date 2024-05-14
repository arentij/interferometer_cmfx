% all_data = zeros(50000000,25);
% 
% for i_shot = 1:25
%     all_data(:,i_shot) = all_day_data_array{i_shot,1};
% end

%%

all_data2 = all_data(1:100:end,:);
%%
std_array = std(all_data2,1);
figure(70)
scatter(1:25,std_array,'filled')
%%
shots = 1:25; %[1:3,5,7,8,11:16,18,21:25]; % baddies  4 6 9 10 17 19 20
av_data = mean(all_data2(:,shots),2);
mean_ad_data = mean(av_data);
%

mvmean_av_data = movmean(av_data,30);

%
figure(98)
plot(mvmean_av_data(1:end)-mean_ad_data);
title(num2str(shots));


%%
N_art = 10000;
t_art  = linspace(0,1e-1,N_art); 
n_shots = 5^2;
art_data_matr = zeros(N_art,n_shots);

for i_art_dt = 1:size(art_data_matr,2)

    w0 = abs(10 + 1*(randn()));
    w1 = 380+ 10*randn();
    w2 = w1 + 2*randn();
    
    a0 = 100;
    a1 = 1;
    a2 = 1;
    
    phi0 = 2*pi*rand();
    phi1 = 2*pi*rand();
    phi2 = 2*pi*rand();
    
    
    
    
    artificial_data = a0*sin(2*pi*w0*t_art+phi0) +a1*sin(2*pi*w1*t_art+phi1) + a2*sin(2*pi*w2*t_art+phi2); 
    artificial_data = artificial_data +randn(size(artificial_data));

    art_data_matr(:,i_art_dt) = artificial_data;

end

%

figure(110);
clf
hold on
plot(art_data_matr(:,1),'LineWidth',2,'Color','r')
plot(art_data_matr(:,2),'LineWidth',2,'Color','g')

subs = [1:n_shots];
plt_av = mean(art_data_matr(:,subs),2);
plot(plt_av,'LineWidth',3,'Color','b')
title(['swing='  num2str(0.5*(max(plt_av)-min(plt_av))) '  N= '  num2str(n_shots)])