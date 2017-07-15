syms x1 x2 x3 x4 x5 x6 x7 x8 x9 x10;
lb = LinearSystemBuilder([(10*x1 + 2*x2 + 3*x3 - 7) (x1 + 5*x2 + x3 - 8) (2*x1 + 3*x2 + 10*x3 -6)]);
numVariables = length(lb.getAllVariables);
Matrix = lb.createSystem();

tolerance = 0.05;
x0 = [0.7; -1.6; 0.6];
tries = 100;

if(numVariables ~= length(x0))
    error('Dimension of estimation matrix does not match system''s number of variables');
end

for i = 1:numVariables
    pivot = -1/Matrix(i,i);
    newRow = Matrix(i,:) * pivot;
    Matrix(i,:) = newRow;
    Matrix(i,i) = 0;
    Matrix(i,end) = - Matrix(i,end); 
end

C = Matrix(:,1:end -1);
g = Matrix(:,end);

runs = 0;
while runs < tries 
    xk =  (C * x0) + g;
    dk = max(abs(xk - x0));
    dr = dk/(max(xk));
    if (dr <= tolerance)
        break;
    end
    
    x0 = xk;
    runs = runs + 1;
 
end

approxs = xk(:)';
result = lb.generAprxResults(xk);
disp(runs);
disp(approxs);
disp(result);

