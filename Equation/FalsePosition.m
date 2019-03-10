syms x a b
format long
n = ResultPrecisionChecker(x * log10(x) -1, 0.1e-20);
ct = ConvergenceTester(x * log10(x) -1);
tries = 5000;
a = 2;
b = 3;

root = 'Not found';
run = 0;
previous = 0;
while run < tries
    F = vpa(subs(n.Equation, symvar(n.Equation,1), a));
    G = vpa(subs(n.Equation, symvar(n.Equation,1), b));
    xk = (a*G -b*F)/(G - F);
    root = xk;
    
    if n.checkAbsoluteError(xk) == 1
        break;
    end
    if run > 0
        if n.checkRelativeError(xk, previous) == 1
            break;
        end
    end
    
    
    if ct.existsSomeRootAtInterval(a, xk) == 1
        b =xk;
    else
        a = xk;
    end
    
    run = run + 1;
    previous = xk;
end

disp(run); % Displays times the Method was run
disp(root); % Displays root approximation
disp(vpa(subs(n.Equation,symvar(n.Equation,1),root))); % Displays y at root 
