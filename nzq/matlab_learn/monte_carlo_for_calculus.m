
clc,clear
x= unifrnd(0,12,[1,1e7]);
y= unifrnd(0,9,[1,1e7]);
frequency = sum(y<x.^2 & x<=3)+sum(y<12-x & x>=3);
12*9*frequency/1e7