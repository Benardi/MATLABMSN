syms x a b
format long
equ(x) = x^3 -x - 1;
n = NumericalEquationSolver(equ(x), 0.0000000000001);
n.setInterval(-100,100);
tries = 150; 
a = 0;
b = 10;

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
disp(root);
disp(vpa(equ(root)));
disp(run);