%% ��һ��
x = normrnd(0,sqrt(0.25),4,1)%%�ھ�ֵΪ0������Ϊ0.25����̬�ֲ����漴ȡ���ĸ�����
mu = 0.01;
sigma = 0.15;
T =1;
K = 1.5;
S0 = 1;%%��S0Ϊ1
n = 4;%% n��Tʱ����ڵ���������
delta = T/n;

%�γɲ����˶�
Wt = zeros(n,1);
%cbm���ۻ������˶�
CWt = zeros(n,1);
Wt(1) = normrnd(0,sqrt(delta))%%����ȷ����һ���������
CWt(1) = Wt(1);%%ͬʱ��һ���ۻ��Ĳ����˶��͵��ڵ�һ���������

%����������͹�Ʊ�۸����ѭ���ֱ�õ����Ե�·����Ȼ��ֱ����ʼ��0���ϣ��γ�������·��
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

%��ͼ
subplot(2,1,1), plot(axis,newcbm)%%�������Ĭ�ϻ���
hold on
plot(axis,newcbm,'*')%%���������ÿ�����ϼ���*�������ͬ��
xlabel('Time')
title('Brownian Motion Path')
hold off
subplot(2,1,2), plot(axis,newstock)
hold on
plot(axis,newstock,'*')
xlabel('Time')
title('Stock Price Path')
hold off


%% ������
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
subplot(3,1,1), plot(axis,newCWt)%%�������Ĭ�ϻ���
hold on
plot(axis,newCWt,'*')%%���������ÿ�����ϼ���*�������ͬ��
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




