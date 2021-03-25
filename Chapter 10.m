%% 第二题 生成3个总时长为8天的St的随机路径
m = 3;%模拟的次数
n = 4;%每次模拟生成4个随机数
stock = zeros(m,n+1);
stock(:,1) = 940;%生成0矩阵，行数为模拟的次数，列数为价格序列数，且第一列均为初始价格
for j = 1:m
    for i = 2:n+1
        x = binornd(1,0.5);%x is either 1 (heads) or 0 (tails)
        if x == 1
            dw = sqrt(2);
        else
            dw = -sqrt(2);
        end
        stock(j,i) = stock(j,i-1)*exp(0.0775+0.15*dw);
        %计算出的是每一条路径上的各个点，每个点都由相对应的一个随机变量决定，且这种算法依赖于要算出前面的值
    end
end


%path 1
stock(1,:)

%path 2
stock(2,:)

%path 3
stock(3,:)

%% 第三题 (a)生成随机变量;(b)作出St的拟合轨迹;(c)求看涨期权的价值
%参数设置
sigma = 0.05;
T = 1;
K = 1;
r = 0.03;
S0 = 1;
n = 5;
delta = T/n;
%生成随机变量并计算随机变量的累加值
bm(1) = normrnd(0,sqrt(delta));
cbm(1) = bm(1);
for j = 2:n
    bm(j) = normrnd(0,sqrt(delta));
    cbm(j) = cbm(j-1) + bm(j);
end

for j = 1:n
    stock(j) = S0*exp((r*j*delta)+sigma*cbm(j)-(1/2)*(sigma^2)*j*delta);
    %这种算法要求出每个路径点上随机变量的累加值，但不用递归得出每个路径点上的St，本质和上面一个方法一样
end

call = exp(-r*T) * max(0, stock(n) - K)
%call value (one simulation)

stock
%one possible stock price path

%% 第三题(d)再取5个同分布随机数，重复试验
%若要让均值继续为0，方差仍然为0.2，则必须让均匀分布的取值范围为[-sqrt(0.6),sqrt(0.6)]
sigma = 0.05;
T = 1;
K = 1;
r = 0.03;
S0 = 1;
%n is the number of discretizations for T
n = 5;
delta = T/n;
bm(1) = unifrnd(-sqrt(.6),sqrt(.6));
cbm(1) = bm(1);
for j=2:n
    bm(j) = unifrnd(-sqrt(.6),sqrt(.6));
    cbm(j) = cbm(j-1) + bm(j);
end
for j = 1:n
    stock(j) = S0*exp((r*j*delta)+sigma*cbm(j)-(1/2)*(sigma^2)*j*delta);
end
%generate European call price
%stock(n) is final stock price, stock(T)
call = exp(-r*T) * max(0, stock(n) - K)
%call value (one simulation)
stock
%one possible stock price path

%% 第三题(e)如果我们将该实验进行1000次，其中任意两次试验得到的期权价格会有明显差别吗
for k=1:1000
    sigma = .05;
    T = 1;
    K = 1;
    r = .03;
    S0 = 1;
    %n is the number of discretizations for T
    n = 5;
    delta = T/n;
    bm_normal(1)=normrnd(0,sqrt(delta));
    cbm_normal(1) = bm_normal(1);
    bm_uniform(1)=unifrnd(-sqrt(.6),sqrt(.6));
    cbm_uniform(1) = bm_uniform(1);
    for j=2:n
        bm_normal(j) = normrnd(0,sqrt(delta));
        cbm_normal(j) = cbm_normal(j-1) + bm_normal(j);
    bm_uniform(j) = unifrnd(-sqrt(.6),sqrt(.6));
    cbm_uniform(j) = cbm_uniform(j-1) + bm_uniform(j);
    end
    for j=1:n
        stock_normal(j) = S0*exp((r*j*delta)+sigma*cbm_normal(j)-(1/2)*(sigma^2)*j*delta);
        stock_uniform(j) = S0*exp((r*j*delta)+sigma*cbm_uniform(j)-(1/2)*(sigma^2)*j*delta);
    end
    %generate European call price
    %stock(n) is final stock price, stock(T)
    call_normal(k) = exp(-r*T) * max(0, stock_normal(n) - K);
    call_uniform(k) = exp(-r*T) * max(0, stock_uniform(n) - K);
end
avgnormal=mean(call_normal)
%call value using Normal approximation
avguniform=mean(call_uniform)
%call value using Binomial approximation

%The two prices are similar. 
%In general, the central limit theorem could be invoked if n were increased.
%The sum of independent uniform random variables with a common mean converges to a normal distribution.

%% 第三题(f)我们能否将两份蒙特卡洛样本结合起来，构成2000条路径来计算看涨期权价格
%Yes, the paths may be combined. 
%However, the accuracy of the expectation also depends on the number of nodes in the sample path 
%and not just the number of sample paths. (不仅需要路径数够多，而且每一条路径上的点要够多，这样这两种方法计算出来的期权价格才可以组合利用)


%% 第四题 画出St的轨迹图
function [time_interval,stock] = stock_price(n)
S0 = 100;
T = 3;
delta = T/n;
time_interval = [0:delta:3];
sigma = 0.1;
stock = zeros(1,n+1)
stock(1) = 1;

for i = 2:n+1
    x = binornd(1,.5);%x is either 1 (heads) or 0 (tails)
    if x == 1 
        dw = sqrt(delta);
    else
        dw = -sqrt(delta);
    end
    stock(i) = stock(i-1) + 0.05 * delta + sigma * dw;
end
end
%% 调用函数
[b,c] =stock_price(2000)
plot(b,c)
title('Path of Stock Price')
%xlabel('Time')
