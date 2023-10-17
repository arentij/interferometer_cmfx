N_pts = 10000;
x = t_array(1:N_pts)';
y = signal(1:N_pts);

figure(800)
dt = 0.1;
x = linspace(0,dt,fs*dt)';
y = cos(2*pi*fc*x+1)+0e-3*randn(size(x));
% plot(x,y)

%%
% x = rand(200,1)*5;
% y = 4*sin(10*x + 3) + randn(size(x))/10;

fs = 0.5e9;
fc_approx = 40e6;

dl_fit = 5e-6;
N_d = length(y);
dt_ar = [1:fix(dl_fit*fs),N_d - fix(dl_fit*fs):N_d];

mdl = fittype('a*sin(2*pi*b*x+c)','indep','x');
fittedmdl2 = fit(x(dt_ar),y(dt_ar),mdl,'start',[1.1 (fc-rand()) 0.5]);

a1 = fittedmdl2.a;
b1 = fittedmdl2.b;
c1 = fittedmdl2.c;

y2 = a1*sin(2*pi*b1*x+c1);
clf
subplot(2,1,1)
hold on
plot(x,y,'b')
plot(x,y2,'r--')
% plot(fittedmdl2)
xlim([0 0.000001])
hold off

subplot(2,1,2)

hold on
plot(x,y,'b')
plot(x,y2,'r--')
% plot(fittedmdl2)
xlim([dt-0.000001 dt])
hold off
%%
fittedmdl2
err = (fc_approx-b1)