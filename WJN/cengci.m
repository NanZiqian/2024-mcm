
A=[1 7 4 3;1/7 1 1/3 1/4;1/4 3 1 1;1/3 4 1 1];
%disp('请输入准则层判断矩阵A(n阶)');
%A=input('A=');
[n,n]=size(A);

Sum_A=sum(A);
SUM_A=repmat(Sum_A,n,1);
Stand_A=A./SUM_A;
disp('算术平均法求权重的结果为：')
disp(sum(Stand_A,2)./n);

Prduct_A=prod(A,2);
Prduct_n_A=Prduct_A.^(1/n);
disp('几何平均法求权重的结果为：')
disp(Prduct_n_A./sum(Prduct_n_A));


[V,D]=eig(A);%求得特征向量和特征值
            %求出最大特征值和它所对应的特征向量
tempNum=D(1,1);
pos=1;
for h=1:n
    if D(h,h)>tempNum
        tempNum=D(h,h);
        pos=h;
    end
end    
w=abs(V(:,pos));
w=w/sum(w);
t=D(pos,pos);
disp('准则层特征向量w=');disp(w);disp('准则层最大特征根t=');disp(t);
         %以下是一致性检验
CI=(t-n)/(n-1);RI=[0 0 0.52 0.89 1.12 1.26 1.36 1.41 1.46 1.49 1.52 1.54 1.56 1.58 1.59 1.60 1.61 1.615 1.62 1.63];
CR=CI/RI(n);
if CR<0.10
    disp('此矩阵的一致性可以接受!');
    disp('CI=');disp(CI);
    disp('CR=');disp(CR);
else disp('此矩阵的一致性验证失败，请重新进行评分!');
end


disp('请输入方案层各因素对准则层各因素权重的成对比较阵');
for i=1:n
    disp('请输入第');disp(i);disp('个准则层因素的判断矩阵B');disp(i);
end
    disp('此矩阵的一致性可以接受!');
    disp('CI=');disp(CI);
    disp('CR=');disp(CR);



disp('请输入方案层各因素对准则层各因素权重的成对比较阵');
for i=1:n
    disp('请输入第');disp(i);disp('个准则层因素的判断矩阵B');disp(i);
end
