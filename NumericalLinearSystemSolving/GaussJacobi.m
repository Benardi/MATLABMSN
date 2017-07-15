syms x;

f(x) = 5*x^3 -2*x -6;
g(x) = 26*x^2 + 3*x^5;
h(x) = 12*x + 19*x^3 - 5;


lb = LinearSystemBuilder([(5*x^3 -2*x -6) (26*x^2 + 3*x^5) (12*x + 19*x^3 - 5) (-1*x^8 -9*x^6) ] );
disp(lb.highestDegree());
system = lb.buildsLinearSystem();

display(system)

