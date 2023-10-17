function [l] = l_s(s,f1,f2,r1)
%L_S Summary of this function goes here
%   Detailed explanation goes here

f1 = abs(f1);
f2 = abs(f2);


lambda = 10.6e-6;
w0 = 1.2e-3;
del_l = pi*w0^2/lambda;

a = 1/f2 - 1/f1 + s/(f1*f2);
b = 1 + s/f1;
c = r1/f2 + s/f2 + s*r1/(f1*f2) - r1/f1 - 1;
d = r1 + s + s*r1/f1;
e = 1/f1 - 1/f2 - s/(f1*f2);
f = 1 + r1/f1 - r1/f2 - s/f2 - s*r1/(f1*f2);

l = (a*b*del_l^2+c*d)/(e^2*del_l^2+f^2);


end

