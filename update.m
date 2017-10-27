function [ theta ] = update( norm, price, rate, iter, theta )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    for i =  1:iter
        guess = norm*theta;
        error = guess-price;
        minus = (rate * (1/length(price)) * error' * norm)';
        theta = theta - minus;
    end
end

