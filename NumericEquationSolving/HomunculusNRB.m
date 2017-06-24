syms x a b
format long
n = NumericalEquationSolver(x*exp(-(x^2)), 0.1e-10);
ct = ConvergenceTester(x*exp(-(x^2)), 0.1e-10);
tries = 5000; 
a = -1;
b = 4;
run = 0;

for i = 1:2
    % calls Bisection Method
    xk = (a + b)/2;        
    root = xk;

    if ct.testTheorem1(a, xk) == 1
        b = xk;       
    else
        a = xk;
    end
    
    if n.testExactMatch(xk) == 1
        run = tries;
        break;
    end 
    
    if(run > 0)
        if n.testTolerance(xk, previous) == 1
            run = tries;
            break;
        end      
    end
    
end

previous = xk;

while run < (tries -2) % calls Newton's Method
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
    
    previous = xk;     
    run = run + 1;
    
end

disp(run);
disp(root);
disp(vpa(subs(n.Equation,symvar(n.Equation,1),root)));
