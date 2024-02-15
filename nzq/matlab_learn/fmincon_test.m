
fun1 = @(x) sum(x.^2)+8;
nonlcon = @fun2;
[x,y] = fmincon(fun1,rand(3,1),[],[],[],[],zeros(3,1),[],nonlcon)

function [g,h] = fun2(x)
    g = [-x(1)^2+x(2)-x(3)^2,
        x(1)+x(2)^2+x(3)^3-20];
    h = [-x(1)-x(2)^2+2,
        x(2)+2*x(3)^2-3];
end