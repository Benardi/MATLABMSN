classdef ResultPrecisionChecker
    % RESULTPRECISIONCHECKER Class that tests if a result is precise enough.
    % This class tests if a given root  is within a given level of precision.
    % This class provides the relative error as a checking condition.    
    
    properties
        Equation % Equation whose root approximation is being tested.
        Precision % The stipulated level of precision.
    end
    
    methods
        function obj = RootPrecisionChecker(equation, precision)
            if nargin > 0
                if strcmp(class(equation),'sym') == 0
                    error('Insert a symbolic function')
                elseif isnumeric(precision) == 0
                    error('Insert a numeric value')
                else
                    obj.Equation = equation;
                    obj.Precision = precision;
                end
            end
        end
        
        
        function r = testTolerance(obj, entry, previous)
        % Method tests whether root is within acceptable precision level.
        % f(x) at given root or relative error are testing parameters.
        
            relativeError = abs((entry - previous)/entry);
            estimation = abs(vpa(subs(obj.Equation,symvar(obj.Equation,1),entry)));
            if estimation <= obj.Precision || relativeError <= obj.Precision
                r = 1;
            else
                r = 0;
            end
            
        end
        
        function r = testExactMatch(obj, entry)
        % This method tests whether parameter is exact root of function
        
            estimation = abs(vpa(subs(obj.Equation,symvar(obj.Equation,1),entry)));
            if estimation == 0
                r = 1;
            else
                r = 0;
            end
            
        end
    end
    
end



