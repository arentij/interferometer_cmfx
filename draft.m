f = 150e-3;
R1 = 154e-3;
D0 = 0.9*25.4e-3;
mu = 1+R1/2/f;

r_sens = 150e-6;

Dls = 195e-3;
%% lets have a ray coming from (z0; y0) into (0, y1)

z0 = -100e-3;
y0 = 6e-3;
z1 = 0;

%% let's have a 2D space between - 50 mm and -1000 mm in Z and -D0 and +D0 in Y
z_space = linspace(-50e-3,-1000e-3,100);
y_space = linspace(-D0,D0,10);

P_space = zeros(length(z_space), length(y_space));

%%
% it goes to 

% y1 = -5e-3;

% lets plot it

% figure(1)
% clf
% line([-300e-3, 300e-3],[0,0],'color','black')
% line([0,0],D0*[-0.5, 0.5],'color','cyan')
% 
% line([z0, z1], [y0, y1],'color','red');
% 
% k0 = (y1-y0)/(z1-z0);
% 
% k1 = k0-y1/f;
% 
% z2 = 190e-3;
% y2 = k1*z2+y1;
% 
% line([z1,z2],[y1,y2],'color','blue')
% title('Tests')
%%
% now let's have a point source at (z0, y0) and let's shoot N rays
N = 11;

figure(2)
clf
line([-300e-3, 300e-3],[0,0],'color','black')
line([0,0],D0*[-0.5, 0.5],'color','cyan')

y1_arr = linspace(-D0/2,D0/2,N);
hit = 0;
for ray_i = 1:N
    
    y1 = y1_arr(ray_i);
    line([z0, z1], [y0, y1],'color','red');

    k0 = (y1-y0)/(z1-z0);
    
    k1 = k0-y1/f;
    
    z2 = Dls;
    y2 = k1*z2+y1;
    if ray_i == 1
        min_y2 = y2;
        max_y2 = y2;
    else
        min_y2 = min(y2,min_y2);
        max_y2 = max(y2,max_y2);
    end

    if abs(y2) <=r_sens
        line([z1,z2],[y1,y2],'color','blue')
        hit = hit+1;
    else
        line([z1,z2],[y1,y2],'color','yellow')
    end

    

end

%%
f*Dls/(Dls-f);

line([z2, z2],[min_y2, max_y2],'color','magenta');
%%
ktop = (D0/2-y0)/(z1-z0);
kbot = (-D0/2-y0)/(z1-z0);

line([z0, z1],[y0,(z1-z0)*ktop+y0],'color','magenta');
line([z0, z1],[y0,(z1-z0)*kbot+y0],'color','magenta');

ktop1 = ktop - D0/2/f;
kbot1 = kbot + D0/2/f;
y2max = Dls*ktop1+D0/2;
y2min = Dls*kbot1-D0/2;



line(1e-3+[z2, z2],[y2max, y2min],'color','green');
%%
% overlap surface
r_img = 0.5*abs(y2max - y2min);
y2_center_img = max(y2max, y2min) - r_img;

cir_ov = circ_overlap(r_sens,r_img,abs(y2_center_img));

% detected ratio of the signal on the light spot
obs_sig = cir_ov/(pi*r_img^2);


(hit/N)^2;

%% total power that went to the lens (if the actual total power emitted in 4*Pi is 1)
P0 = (D0/2)^2/4/(z1-z0)^2;
% observed power
P1 = P0*obs_sig