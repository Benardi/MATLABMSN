syms x a b
format long
n = NumericalEquationSolver(x^4 + 3*x^3 -15*x^2 -2^x + 9, 0.1e-10);
tries = 5000; 
a = -8;
b = -4;
r = n.testIntervalBisection(a,b,1);

if r == 0
    disp('Interval does not meet requirements');
    return
end

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
