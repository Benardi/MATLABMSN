syms x a b
format long
n = NumericalEquationSolver(x^2 - 4, 0.0000000000000000000000001);
n.testInterval(0,100);
tries = 5000; 
a = 1;
b = 2;

root = 'Not found';
run = 0;

while run < tries
    xk = (a + b)/2;
    root = xk;
    
    if n.testCandidate(xk) == 1
        break;
    end    
        
    if n.testTheorem1(a, xk) == 1
       b = xk;
               
    else
       a = xk;
    end
    run = run + 1;
                       
end
disp(run);
disp(root);
disp(vpa(subs(n.Equation,symvar(n.Equation,1),root)));
