%% 第一题
x = normrnd(0,sqrt(0.25),4,1)%%在均值为0，方差为0.25的正态分布中随即取出四个数字
mu = 0.01;
sigma = 0.15;
T =1;
K = 1.5;
S0 = 1;%%设S0为1
n = 4;%% n是T时间段内的子区间数
delta = T/n;

%形成布朗运动
Wt = zeros(n,1);
%cbm是累积布朗运动
CWt = zeros(n,1);
Wt(1) = normrnd(0,sqrt(delta))%%首先确定第一个随机变量
CWt(1) = Wt(1);%%同时第一个累积的布朗运动就等于第一个随机变量

%对随机变量和股票价格进行循环分别得到各自的路径，然后分别与初始点0相结合，形成完整的路径
for j = 2:n
    Wt(j) = normrnd(0,sqrt(delta));
    CWt(j) = CWt(j-1) + Wt(j);
end

axis = (0:delta:T);
newcbm = [0;CWt]';

Xt = zeros(n,1);
for j = 1:n
    Xt(j) = S0 * exp(mu * j *delta + sigma * CWt(j));
end

newstock = [S0;Xt]';

%画图
subplot(2,1,1), plot(axis,newcbm)%%这条语句默认画线
hold on
plot(axis,newcbm,'*')%%这条语句在每个点上加上*，下面的同理
xlabel('Time')
title('Brownian Motion Path')
hold off
subplot(2,1,2), plot(axis,newstock)
hold on
plot(axis,newstock,'*')
xlabel('Time')
title('Stock Price Path')
hold off


%% 第三题
mu = 0.1;
sigma = 0.15;
T = 0.5;
n = 100;
delta = T/n;
X0 = 1;
Wt = zeros(n,1);
Wt(1) = normrnd(0,sqrt(delta));
CWt = zeros(n,1);
CWt(1) = Wt(1);
for j = 2:n
    Wt(j) = normrnd(0,sqrt(delta));
    CWt(j) = CWt(j-1) + Wt(j);
end

Xt = zeros(n,1);
Yt = zeros(n,1);
for j = 1:n
    Xt(j) = X0 + mu * j * delta + sigma * Wt(j);
    Yt(j) = exp(Xt(j));
end

axis = (0:delta:T);
newCWt = [0;CWt]';
newXt = [0;Wt]';
newYt = [0;Yt]';

figure(1)
subplot(3,1,1), plot(axis,newCWt)%%这条语句默认画线
hold on
plot(axis,newCWt,'*')%%这条语句在每个点上加上*，下面的同理
xlabel('Time')
title('Brownian Motion Path')
hold off
subplot(3,1,2), plot(axis,newXt)
hold on
plot(axis,newXt,'*')
xlabel('Time')
title('Xt Path')
hold off
subplot(3,1,3), plot(axis,newYt)
hold on
plot(axis,newYt,'*')
xlabel('Time')
title('Yt Path')
hold off

figure(2)
hist(Xt)

figure(3)
hist(Yt)




