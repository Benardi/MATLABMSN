syms x a b
format long
n = NumericalEquationSolver(exp(x), 0.01e-90);
tries = 1000; 
a = -1;
b = 2;
n.testIntervalBissection(a,b,1);

root = 'Not found';
run = 0;
previous = 0;
while run < tries
    xk = (a + b)/2;
    root = xk;
    
    if n.testExactMatch(xk) == 1
        break;
    end  
    if(run > 0)
        if n.testTolerance(xk, previous) == 1
            break;
        end      
    end
    
    if n.testTheorem1(a, xk) == 1
       b = xk;
               
    else
       a = xk;
    end
    run = run + 1;
    previous = xk;                   
end
disp(run);
disp(root);
disp(vpa(subs(n.Equation,symvar(n.Equation,1),root)));
