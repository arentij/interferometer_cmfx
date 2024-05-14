angles = linspace(-pi/5,pi/5,10000);
d_w = 5e-3;

lambda_co2 = 10.6e-6;
lambda_red = 0.639e-6;

dphidalpha_red = 2*pi*d_w/lambda_red*sin(angles)./cos(angles).^2;
dphidalpha_co2 = 2*pi*d_w/lambda_co2*sin(angles)./cos(angles).^2;

figure(60)
clf; hold on
plot(angles*360/2/pi,dphidalpha_red/1e3,'r','LineWidth',3)
plot(angles*360/2/pi,dphidalpha_co2/1e3,'k--','LineWidth',3)

figure(61)
clf; hold on
plot(angles*360/2/pi,1e6*0.17*dphidalpha_red*lambda_red/1e3,'b','LineWidth',3)
xlabel('Angle of the window, c')
ylabel('Interferometers separation per mrad of rotation, um/mrad')