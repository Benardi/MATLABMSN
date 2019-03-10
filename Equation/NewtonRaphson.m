syms x
format long
n = ResultPrecisionChecker(x*exp(-(x^2)), 0.1e-20);
tries = 5000; 
x0 = 1.5;
root = 'Not found';
run = 0;
previous = x0;

while run < tries
    fxk = vpa(subs(n.Equation,symvar(n.Equation,1),previous));
    f1xk = vpa(subs(diff(n.Equation),symvar(n.Equation,1),previous));
    xk = previous - (fxk/f1xk);
    root = xk;

    if n.checkAprxAbsoluteError(xk) == 1
        break;
    end  
    if(run > 0)
        if n.checkAprxRelativeError(xk, previous) == 1
            break;
        end      
    end
    run = run + 1;
    previous = xk;  
end

disp(run); % Displays times the Method was run
disp(root); % Displays root approximation
disp(vpa(subs(n.Equation,symvar(n.Equation,1),root))); % Displays y at root 
