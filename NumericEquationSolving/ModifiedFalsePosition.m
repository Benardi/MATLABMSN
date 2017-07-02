syms x a b
format long
n = ResultPrecisionChecker(x ^2 + x -6, 0.1e-20);
ct = ConvergenceTester(x ^2 + x -6);
tries = 5000;
a = 1;
b = 3;
F = vpa(subs(n.Equation, symvar(n.Equation,1), a));
G = vpa(subs(n.Equation, symvar(n.Equation,1), b));

root = 'Not found';
run = 0;
previous = 0;

while run < tries
    xk = (a*G -b*F)/(G-F);
    root = xk;
    
    if n.checkAbsoluteError(xk) == 1
        break;
    end
    
    if run > 0
        if n.checkRelativeError(xk, previous) == 1
            break;
        end
    end
 
    fxk = vpa(subs(n.Equation, symvar(n.Equation,1), xk));
    if ct.testTheorem1(a, xk) == 1
        b = xk;
        G = fxk;
        if ct.testTheorem1(xk, previous) == 0
            F = F/2;
        end
    else
        a = xk;
        F = fxk;
        if ct.testTheorem1(xk, previous) == 0
            G = G/2;
        end
    end  
    run = run + 1;
    previous = xk;
    
end

disp(run); % Displays times the Method was run
disp(root); % Displays root approximation
disp(vpa(subs(n.Equation,symvar(n.Equation,1),root))); % Displays y at root 

