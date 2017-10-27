filename = 'housing prices.txt';
delimiterIn = ' ';
headerlinesIn = 1;
A = importdata(filename);
sqft = str2double(A.textdata(2:end,1));
price = str2double(A.textdata(2:end,2));
city = A.textdata(2:end,3);
bed = A.data(:,1);
baths = A.data(:,2);

train = floor(length(bed)*.7);

[sqft_norm ,sqft_med, sqft_stndev]  = normalize_col(sqft(1:train));
[bed_norm, bed_med, bed_stndev] = normalize_col(bed(1:train));
[baths_norm, baths_med, baths_stndev] = normalize_col(baths(1:train));

norm = [sqft_norm, bed_norm, baths_norm];

rate = .1;
iter = 500;
theta = zeros(3, 1);

theta  = update(norm, price(1:train), rate, iter, theta);

tsqft = normalize_col(sqft(train+1:end));
tbed = normalize_col(bed(train+1:end));
tbaths = normalize_col(baths(train+1:end));
inp = [tsqft , tbed, tbaths];
tprice = abs(inp*theta);
%Mean Squared Error
MSE = (sum(price(train+1)-tprice).^2)/length(tprice)
test_price = price(train+1:end);
perct = 0;
perc = 0;
for i = 1:length(tprice)
    if(tprice(i) >= 350000)
        perct = perct + 1;
    else
        perct = perct+ 0;
    end
    
    if(test_price(i) >= 350000)
        perc = perc + 1;
    else
        perc = perc+ 0;
    end
end

%Perceptron Error
perceptron = 1-(perct/perc)

% clearly my error is extremely high. I am going to say that this is due to 
% update funtion yielding negative guesses.
