syms x y z;
lb = LinearSystemBuilder([(5*x + y + z - 5) (3*x + 4*y +z - 6) (3*x + 3*y + 6*z)]);
numVariables = length(lb.getAllVariables);
Matrix = lb.createSystem();

tolerance = 0.05;
estimations = [-1; 0; 1];
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

runs = 0;
while runs < tries
    xk = vpa(poly2sym(Matrix(1,1:end-1) * estimations) + Matrix(1,end));
    yk = vpa(poly2sym(Matrix(2,1:end-1) * estimations) + Matrix(2,end));
    zk = vpa(poly2sym(Matrix(3,1:end-1) * estimations) + Matrix(3,end));
    estimations = [xk; yk; zk];
    runs = runs + 1;
end

disp(lb.generAprxResults(estimations));