syms x a b
format long
n = NumericalEquationSolver(exp(x), 0.01e-90);
tries = 1000; 
a = -1;
b = 2;
x0 = 0;
r = n.testIntervalforNewton(a, b, x0, 1);

if r == 0
    disp('Interval does not meet requirements');
    return
end

root = 'Not found';
run = 0;
previous = x0;

while run < tries
    fxk = vpa(subs(n.Equation,symvar(n.Equation,1),previous));
    f1xk = vpa(subs(diff(n.Equation),symvar(n.Equation,1),previous));
    xk = previous - (fxk/f1xk);
    root = xk;

    if n.testExactMatch(xk) == 1
        break;
    end  
    if(run > 0)
        if n.testTolerance(xk, previous) == 1
            break;
        end      
    end
    run = run + 1;
    previous = xk;  
end

disp(run);
disp(root);
disp(vpa(subs(n.Equation,symvar(n.Equation,1),root)));
