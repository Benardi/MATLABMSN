syms x a b
format long
n = ResultPrecisionChecker(x*exp(-(x^2)), 0.1e-20);
tries = 5000; 
a = -1;
b = 4;

root = 'Not found';
run = 0;
previous = 0;
while run < tries
    xk = (a + b)/2;
    root = xk;
    
    if n.checkAbsoluteError(xk) == 1
        break;
    end  
    if(run > 0)
        if n.checkRelativeError(xk, previous) == 1
            break;
        end      
    end
    
    if vpa(subs(n.Equation,symvar(n.Equation,1),a)) * vpa(subs(n.Equation,symvar(n.Equation,1),xk)) < 0
       b = xk;
               
    else
       a = xk;
    end
    run = run + 1;
    previous = xk;                   
end

disp(run); % Displays times the Method was run
disp(root); % Displays root approximation
disp(vpa(subs(n.Equation,symvar(n.Equation,1),root))); % Displays y at root 
