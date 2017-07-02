syms x a b
format long
f(x) = x^2 +x -6; % Original Equation 
g(x) = (6 - x) ^(1/2); % Substitute Equation. Manually set.
n = ResultPrecisionChecker(f(x), 0.1e-20);
x0 = 1.5;
root = 'Not found';
run = 0;
previous = x0;

while run < tries
    xk = vpa(subs(g(x), symvar(g(x),1), previous));
    root = xk;

    if n.checkAbsoluteError(xk) == 1
        break;    
    end
    
    if(run > 0)
        if n.checkRelativeError(xk, previous) == 1
            break;
        end      
    end
    
    run = run + 1;
    previous = xk; 

end

disp(run); % Displays times the Method was run
disp(root); % Displays root approximation
disp(vpa(subs(n.Equation,symvar(n.Equation,1),root))); % Displays y at root 