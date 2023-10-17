lambda = 10.6e-6;
w0 = 2.4e-3;
f1 = -50e-3;
f2_array = [315, 50, 100, 150, 200, 500, 1000]*10^-3;
r1 = 500e-3;
del_l = pi*w0^2/lambda;

%%
f2 = f2_array(2);

N_s = 10000;
s_space = linspace(0.0010,0.49,N_s);
l_space = zeros(size(s_space));
for i_s = 1:N_s
    s_i = s_space(i_s);
    l_space(i_s) = l_s(s_i,f1,f2,r1);


end
%%
figure(11)
clf
plot(s_space,l_space)