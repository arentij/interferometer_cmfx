function [data] = clean_pts(data,toler)
%CLEAN_PTS Summary of this function goes here
%   Detailed explanation goes here

for point_ind = 2:length(data)-1

    if abs(data(point_ind-1) - data(point_ind+1)) < toler
        if abs(data(point_ind) - mean(data(point_ind-1) + data(point_ind+1))) > toler
            data(point_ind) = 0.5*(data(point_ind-1) + data(point_ind+1));
        end
    end

end

