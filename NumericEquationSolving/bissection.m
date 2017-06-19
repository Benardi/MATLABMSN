syms x a b
format long
n = NumericalEquationSolver(x^3 -x - 1, 0.0000000000000000000000001);
tries = 5000; 
a = 1;
b = 2;
n.testIntervalBissection(a,b);

root = 'Not found';
run = 0;
x0 = 0;
while run < tries
    xk = (a + b)/2;
    root = xk;
    
    if n.benchmarkTest(xk, x0) == 1
        break;
    end    
        
    if n.testTheorem1(a, xk) == 1
       b = xk;
               
    else
       a = xk;
    end
    run = run + 1;
    x0 = xk;                   
end
disp(run);
disp(root);
disp(vpa(subs(n.Equation,symvar(n.Equation,1),root)));
