function [A] = circ_overlap(r1,r2,d)
%CIRC_OVERLAP Returns the surface area of two circles with radii r1 and r2
%centers are d away from each other
%   Detailed explanation goes here
    if d > r1+r2
        A = 0;
        return
    elseif min(r1,r2)+d <= max(r1,r2)
        A = min(r1,r2)^2*pi;
    else
        A1 = r1^2*acos((d^2+r1^2-r2^2)/(2*d*r1));
        A2 = r2^2*acos((d^2+r2^2-r1^2)/(2*d*r2));
        A3 = -0.5*sqrt((-d+r1+r2)*(d+r1-r2)*(d-r1+r2)*(d+r1+r2));
        A = A1+A2+A3;
    end
end