syms x1 x2 x3 x4 x5 x6 x7 x8 x9 x10;
lb = LinearSystemBuilder([(10*x1 + 2*x2 + 3*x3) (-3*x3 + 2*x2 + 2) (3*x1+ 2*x2 +x3 +x4 +x5 +x6 +x7 + 9)]);
%system = lb.buildsLinearSystem();
%display(system)

f(x) =(10*x1 + 3*x3);
g(x) = (-3*x3 + 2*x2 + 2);
h(x) = (3*x1+ 2*x2 +x3 +x4 +x5 +x6 +x7 + 9);

lista = lb.getCoefficients(f);
lb.createSystem()
