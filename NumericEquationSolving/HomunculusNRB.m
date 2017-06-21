syms x a b
format long
n = NumericalEquationSolver(x^3 -x -1, 0.0000000000000000000000001);
tries = 5000; 
a = 1;
b = 2;
x0 = 2;
r = n.testIntervalforNewton(a,b,x0,0);

switchVar = 0;
if r == 0
    switchVar = 1;
    return
end

root = 'Not found';
run = 0;
previous1 = x0;
previous2 = 0;
while run < tries
    if switchVar == 0 % calls Newton's Method
        fxk = vpa(subs(n.Equation,symvar(n.Equation,1),previous));
        f1xk = vpa(subs(diff(n.Equation),symvar(n.Equation,1),previous));
        xk = previous - (fxk/f1xk);
        root = xk;
        
        % If Newton's Method generates divergence in xk switchs to Bissection
        if n.testFurtherDivergence(previous, xk) == 1
            switchVar = 1;
        end
        
        if n.benchmarkTest(xk, previous1) == 1
            break;
        end
        
    else % calls Bissection Method
        xk = (a + b)/2;        
        root = xk;

        if n.testTheorem1(a, xk) == 1
            b = xk;
               
        else
            a = xk;
        end
        previous2 = xk;
        
    end
     if n.benchmarkTest(xk, previous1) == 1
        break;
     end
    previous = xk;     
    run = run + 1;
    
end

disp(run);
disp(root);
disp(vpa(subs(n.Equation,symvar(n.Equation,1),root)));
