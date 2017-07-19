syms x y z;
lb = LinearSystemBuilder([(5*x + y + z - 5) (3*x + 4*y +z - 6) (3*x + 3*y + 6*z)]);
numVariables = length(lb.getAllVariables);
Matrix = lb.createSystem();
tolerance = 0.05;
estimations = [-1; 0; 1];
tries = 100;

if(numVariables ~= length(estimations))
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
    tempEstim = [];
    for i=1:size(Matrix,1)
        temp = vpa(poly2sym(Matrix(i,1:end-1) * estimations) + Matrix(i,end));
        tempEstim = [tempEstim; temp];
    end
    
    delta = [];
    for i=1:length(tempEstim)
        if(tempEstim(i) == estimations(i) && estimations(i) == 0)
            delta = [delta 0];
        
        elseif (tempEstim(i) == 0 && estimations(i) ~= 0)
            delta = [delta 1];
        elseif tempEstim(i) ~= 0
            delta = [delta abs((tempEstim(i) - estimations(i))/tempEstim(i))];
            
        end
    end
    if max(delta) < tolerance
        break;
    end
    
    attempt = lb.generAprxResults(tempEstim);
    isTolerable = 1;
    for i = 1:length(attempt)
        if abs(attempt(i)) > tolerance
            isTolerable = 0;
        end
    end
    
    if (isTolerable == 1)
        break;
    end
    
    estimations = tempEstim;
    runs = runs + 1;
end

disp(runs);
disp(lb.generAprxResults(tempEstim));