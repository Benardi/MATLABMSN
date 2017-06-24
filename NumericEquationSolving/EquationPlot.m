syms x;
h = ezplot(x*exp(-(x^2)),-4:4);
hold on 
xL = xlim;
yL = ylim;
set(h,'Color','black');
line([0 0], yL);
line(xL, [0 0]);