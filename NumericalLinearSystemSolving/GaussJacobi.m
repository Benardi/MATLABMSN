syms x;
b = 8;

f(x) = 5*x^3 -2*x -6;
g(x) = 26*x^2 + 3*x^5;
h(x) = 12*x + 19*x^3 - 5;
lb = LinearSystemBuilder([(5*x^3 -2*x -6) (26*x^2 + 3*x^5) (12*x + 19*x^3 - 5)]);
lb.extractPolynomDegree(f);
lb.extractPolynomDegree(g);
lb.extractPolynomDegree(h);
disp(lb.highestDegree());

cf = sym2poly(f);
mmm = lb.createBaseMatrix();
diffe = length(mmm) - length(cf);
display(mmm)

for i = 1:length(cf)
    mmm(1,diffe + i) = cf(1,i);
end    
display(mmm)

