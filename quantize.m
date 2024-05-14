function [data_q] = quantize(data)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[minA, maxA] = bounds(data);
bit = 12;
range = max([abs(minA),abs(maxA),abs(minA-maxA)]);

min_step = 2*range/(2^bit-1);

data_q = round(data/min_step)*min_step;

% % Simulate quantization (mapping to 12-bit values)
% data_q = round((data + range/2) / range * (2^bit - 1));
% 
end

