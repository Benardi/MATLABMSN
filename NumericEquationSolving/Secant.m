syms x
format long
n = ResultPrecisionChecker(x^2 + x - 6, 0.1e-20);
tries = 5000;
x0 = 1.5;
x1 = 1.7;
root = 'Not found';
run = 0;

while run < tries
    fx0 = vpa(subs(n.Equation, symvar(n.Equation,1), x0));
    fx1 = vpa(subs(n.Equation, symvar(n.Equation,1), x1));
    xk = (x0 * fx1 - x1 * fx0)/(fx1 -fx0);  
    root = xk;
    
    if n.checkAbsoluteError(xk) == 1
        break;    
    end
    
    if n.checkRelativeError(xk, x1) == 1
            break;
    end      
    
    
    x0 = x1;
    x1 = xk;
    run = run +1;


end

disp(run); % Displays times the Method was run
disp(root); % Displays root approximation
disp(vpa(subs(n.Equation,symvar(n.Equation,1),root))); % Displays y at root 