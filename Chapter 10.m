%% �ڶ��� ����3����ʱ��Ϊ8���St�����·��
m = 3;%ģ��Ĵ���
n = 4;%ÿ��ģ������4�������
stock = zeros(m,n+1);
stock(:,1) = 940;%����0��������Ϊģ��Ĵ���������Ϊ�۸����������ҵ�һ�о�Ϊ��ʼ�۸�
for j = 1:m
    for i = 2:n+1
        x = binornd(1,0.5);%x is either 1 (heads) or 0 (tails)
        if x == 1
            dw = sqrt(2);
        else
            dw = -sqrt(2);
        end
        stock(j,i) = stock(j,i-1)*exp(0.0775+0.15*dw);
        %���������ÿһ��·���ϵĸ����㣬ÿ���㶼�����Ӧ��һ����������������������㷨������Ҫ���ǰ���ֵ
    end
end


%path 1
stock(1,:)

%path 2
stock(2,:)

%path 3
stock(3,:)

%% ������ (a)�����������;(b)����St����Ϲ켣;(c)������Ȩ�ļ�ֵ
%��������
sigma = 0.05;
T = 1;
K = 1;
r = 0.03;
S0 = 1;
n = 5;
delta = T/n;
%���������������������������ۼ�ֵ
bm(1) = normrnd(0,sqrt(delta));
cbm(1) = bm(1);
for j = 2:n
    bm(j) = normrnd(0,sqrt(delta));
    cbm(j) = cbm(j-1) + bm(j);
end

for j = 1:n
    stock(j) = S0*exp((r*j*delta)+sigma*cbm(j)-(1/2)*(sigma^2)*j*delta);
    %�����㷨Ҫ���ÿ��·����������������ۼ�ֵ�������õݹ�ó�ÿ��·�����ϵ�St�����ʺ�����һ������һ��
end

call = exp(-r*T) * max(0, stock(n) - K)
%call value (one simulation)

stock
%one possible stock price path

%% ������(d)��ȡ5��ͬ�ֲ���������ظ�����
%��Ҫ�þ�ֵ����Ϊ0��������ȻΪ0.2��������þ��ȷֲ���ȡֵ��ΧΪ[-sqrt(0.6),sqrt(0.6)]
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

%% ������(e)������ǽ���ʵ�����1000�Σ�����������������õ�����Ȩ�۸�������Բ����
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

%% ������(f)�����ܷ��������ؿ��������������������2000��·�������㿴����Ȩ�۸�
%Yes, the paths may be combined. 
%However, the accuracy of the expectation also depends on the number of nodes in the sample path 
%and not just the number of sample paths. (������Ҫ·�������࣬����ÿһ��·���ϵĵ�Ҫ���࣬���������ַ��������������Ȩ�۸�ſ����������)


%% ������ ����St�Ĺ켣ͼ
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
%% ���ú���
[b,c] =stock_price(2000)
plot(b,c)
title('Path of Stock Price')
%xlabel('Time')
