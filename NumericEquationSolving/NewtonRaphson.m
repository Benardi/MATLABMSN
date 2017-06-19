syms x a b
format long
n = NumericalEquationSolver(x^3 -9 * x + 3, 0.0000000000000000000000001);
tries = 5000; 
a = -4;
b = -2;
n.testIntervalforNewton(a,b);

root = 'Not found';
run = 0;
x0 = 1.5;
previous = x0;

while run < tries
    fxk = vpa(subs(n.Equation,symvar(n.Equation,1),previous));
    f1xk = vpa(subs(diff(n.Equation),symvar(n.Equation,1),previous));
    xk = previous - (fxk/f1xk);
    root = xk;

    if n.benchmarkTest(xk, previous) == 1
        break;
    end      
       
    run = run + 1;
    previous = xk;  
end

disp(run);
disp(root);
disp(vpa(subs(n.Equation,symvar(n.Equation,1),root)));
