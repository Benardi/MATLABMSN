syms x a b
equ(x) = x^2 - 4;
n = NumericalEquationSolver(x^2 - 4);
n.setInterval(0,10);
tries = 100; 
precision= 0.0001;
a = 0;
b = 10;
root = 'Not found';
run = 0;

while run < tries
    xk = (a + b)/2;
    root = xk;
    
    if n.testCandidate(xk) < precision
        break;
    end    
        
    if n.testTheorem1(a, xk) == 1
       b = xk;
               
    else
       a = xk;
    end
    run = run + 1;
                       
end    
disp(root);
disp(vpa(equ(root)));
disp(run);