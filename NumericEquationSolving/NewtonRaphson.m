syms x a b
format long
n = RootPrecisionChecker(x*exp(-(x^2)), 0.1e-10);
tries = 5000; 
a = -1;
b = 4;
x0 = (a + b)/2;
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
