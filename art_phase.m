function [phase] = art_phase(t_art)
% UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% t_art = linspace(0,100e-3,100e-3*100e3);

rng(2);
w_mirrors = 380 + 5*randn(1,2);
a_mirrors = 1 + 0.58*randn(1,2);
phase_mir = 2*pi*rand(1,2);

phase = a_mirrors(1)*sin(2*pi*w_mirrors(1)*t_art + phase_mir(1));
phase = a_mirrors(2)*sin(2*pi*w_mirrors(2)*t_art + phase_mir(2)) + phase;

w_table = 12+randn();
phase_table = 2*pi*rand();
a_table = 8*(1 + 0.3*randn());

phase = phase + a_table*sin(2*pi*w_table*t_art + phase_table);

t_plasma1 = t_art(fix(end*1/4));
t_plasma2 = t_art(fix(end*3/4));

a_plasma = 1.3*(1+0.1*randn());


plasma_phase = a_plasma*max(0,(sin(12*2*pi*(t_art-t_plasma1)))).^1;

phase = 0.01*phase + plasma_phase;


end

