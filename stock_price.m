function[time_interval,stock] = stock_price(n)
S0 = 100;
T = 3;
delta = T/n;
time_interval = [0:delta:3];
sigma = 0.1;
stock = zeros(1,n+1);
stock(1) = S0;
for i = 2:n+1
    x = binornd(1,0.5);%x is either 1 (heads) or 0 (tails)
    if x == 1 
        dw = sqrt(delta);
    else
        dw = -sqrt(delta);
    end
    stock(i) = stock(i-1) + 0.05 * delta + sigma * dw;
end
end

