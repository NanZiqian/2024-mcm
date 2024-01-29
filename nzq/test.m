
%%
clear
clc
x = 1:9;
y = [1,3,5,7,9,7,5,3,1]/2;

b = bar3(x,y);
caxis([0,5])
c = colorbar
colormap('jet')
for k = 1:length(b)
    zdata = b(k).ZData;
    b(k).CData = zdata;
    b(k).FaceColor = 'interp';
end
hold on
view(-90,0)