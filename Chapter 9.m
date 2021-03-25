%% Example one
%求函数f(x)=(1-x^2)*sin5x在闭区间[-2pai,2pai]上的最小值和最大值

x = unifrnd(-2*pi,2*pi,100000,1);%生成（连续）均匀分布的随机数
f = (1-x.^2).*sin(5*x);
fmax = max(f)
figure(1)
plot(x,f,'.')%画出散点图
figure(2)
%polyfit(x,f,3)%自动拟合曲线，第三个参数是拟合的多项式的系数

%% Example two：求定积分e^(x^2+1)
%方法一：随机模拟法

f = inline('exp(x.^2+1)','x');%定义函数
%f = @(x) exp(x.^2+1)%另外一种定义函数的方法：函数句柄
quad(f,0,1)

%方法二：随机模拟法求定积分
n = 100000
xi = unifrnd(0,1,n,1);%在0和1之间生成（连续）均匀分布的随机数
y = exp(xi.^2+1);
xi = unifrnd(0,exp(2),n,1);
%yi = randi([0 8],100000,1);%生成给定范围内的100000个随机数,y的范围应该在exp(1)和exp(2）之间，但randi中范围的参数一定要是整数，所以选择0和8
k = 0;
for i = 1:n
    if yi(i) <= y(i)%如果随机数小于给定方程的值，即该点落在曲线下方，则数目+1
        k = k+1;
    end
end
S = k * exp(2)/n %通过曲线下的点数和整个点数以及面积之比，得出定积分的值。
%具体而言：曲线下的点/整个范围内的点（100000）=定积分的值/整个范围的面积

%% Example three：求二重积分
%方法一：随机模拟法
f = @(x,y) exp(sqrt(1+x.^2+y.^2));%@在匿名函数中表示函数句柄
quad2d(f,0,1,1,4)%逼近fun(x,y)在平面区域a<x<b,c<y<d上的积分

%方法二：随机模拟法
x = unifrnd(0,1,1000000,1);
y = unifrnd(1,4,1000000,1);
z = exp(sqrt(1+x.^2+y.^2));
zi = unifrnd(0,70,1000000,1);%e^(sqrt(18))接近70
k = 0;
for i = 1:1000000
    if zi(i) <= z(i)
        k = k+1;
    end
end
P = k/1000000*210 %曲线下的点/整个范围内的点（100000）=定积分的值/(70*3*1)
plot3(x,y,z,'.')

%% Example four画二重积分的三维图像
x = linspace(0,1,100);
y = linspace(1,4,100);
[X,Y] = meshgrid(x,y);
f = exp(sqrt(1+X.^2 + Y.^2));
%surf(X,Y,f,'FaceAlpha',0.5)%曲面的透明度
surf(X,Y,f,'FaceColor',[0 0.4470 0.7410])%曲面的颜色

%% 维纳过程的简易模拟1
randn('state',10000)          % 随机数都是由RandStream随机数据流生成的（里面有一套固定的算法，一般用时间发生装置）,
                              % 其中就有'state'，'seed'，'twister'等参数,'state'是对随机发生器的状态进行初始化，并且定义该状态初始值
T = 1; N = 500; dt = T/N;

dW = sqrt(dt)*randn(1,N);   % increments
W = cumsum(dW);             % cumulative sum

plot([0:dt:T],[0,W],'r-')   % plot W against t






