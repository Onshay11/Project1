function [ norm, avg , stndev ] = normalize_col( x )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    avg = mean(x);
    norm = x-avg;
    stndev = std(x);
    norm = norm / stndev;
end

