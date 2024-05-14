f = 150e-3;
R1 = 154e-3;
D0 = 0.9*25.4e-3;
mu = 1+R1/2/f;

r_sens = 0.5*150e-6;  %APD 230e-6 diam; % IR Diode d = 150e-6;

Dls = 189e-3;

z1 = 0;
%% let's have a 2D space between - 50 mm and -1000 mm in Z and -D0 and +D0 in Y
z_space = linspace(-50e-3,-1000e-3,10001);
y_space = linspace(-D0/3,D0/3,1001);

P_space = zeros(length(z_space), length(y_space));


for z_ind = 1:length(z_space)
    z0 = z_space(z_ind);
    for y_ind = 1:length(y_space)
        y0 = y_space(y_ind);
        
        %
        ktop = (D0/2-y0)/(z1-z0);
        kbot = (-D0/2-y0)/(z1-z0);
        ktop1 = ktop - D0/2/f;
        kbot1 = kbot + D0/2/f;
        y2max = Dls*ktop1+D0/2;
        y2min = Dls*kbot1-D0/2;
        
        
        % overlap surface
        r_img = 0.5*abs(y2max - y2min);
        y2_center_img = max(y2max, y2min) - r_img;
        
        cir_ov = circ_overlap(r_sens,r_img,abs(y2_center_img));
        
        % detected ratio of the signal on the light spot
        obs_sig = cir_ov/(pi*r_img^2);
        
        % total power that went to the lens (if the actual total power emitted in 4*Pi is 1)
        P0 = (D0/2)^2/4/(z1-z0)^2;
        % observed power
        P_space(z_ind,y_ind) = P0*obs_sig;

    end
end
%%
figure(42)
% heatmap(P_space)
% imagesc(P_space')

h = pcolor(z_space,y_space,P_space');
set(h, 'EdgeColor', 'none');


figure(43)
plot(z_space,sum(P_space,2))

figure(44)
plot(y_space,sum(P_space,1))

%%
figure(45)
i_z = 6000;
z_plt = z_space(i_z);    
plot(y_space,P_space(i_z,:))
title(['Z = ' num2str(z_plt)])





figure(48)
inches = linspace(0,36,360); % on the marking
m_dist = 338e-3-152e-3+25.4e-3*inches;

plot(inches,m_dist)