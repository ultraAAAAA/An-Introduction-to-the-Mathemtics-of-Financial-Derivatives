%有限差分法计算期权价格
Matrix = zeros(5,5);
Matrix(:,5) = [6,6,6,6,6]';%题目中给定的边界条件
Matrix(1,:) = [0,0,0,3,6];%这列数字的意思是到期后期权的价值，因为到t时股票价格分别为0 3 6 9 12，故期权的价值为0 0 3 6 9
for k=1:4
    for j=4:-1:2
        Matrix(k+1,j)=Matrix(k,j)+(5/36)*(Matrix(k,j+1)-2*Matrix(k,j)+Matrix(k,j-1));%由偏微分方程给定
    end
end
Matrix
