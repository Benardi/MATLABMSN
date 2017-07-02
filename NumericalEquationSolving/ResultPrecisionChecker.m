classdef ResultPrecisionChecker
    % RESULTPRECISIONCHECKER Class that tests if a result is precise enough.
    % This class tests if a given root  is within a given level of precision.
    % This class provides the relative error as a checking condition.    
    
    properties
        Equation % Equation whose root approximation is being tested.
        Precision % The stipulated level of precision.
    end
    
    methods
        function obj = ResultPrecisionChecker(equation, precision)
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
        
        
        function r = checkRelativeError(obj, entry, previous)
        % Method tests whether estimation's relative error is zero or precise enough.
        
            relativeError = abs((entry - previous)/entry);
            if relativeError == 0 || relativeError <= obj.Precision
                r = 1;
            else
                r = 0;
            end
            
        end
        
        function r = checkAprxRelativeError(obj, entry, previous)
        % Method tests whether the estimation's is precise enough.
        
            relativeError = abs((entry - previous)/entry);
            if relativeError <= obj.Precision
                r = 1;
            else
                r = 0;
            end
            
        end
        
        function r = checkAbsoluteError(obj, entry)
        % This method tests whether f(entry) is zero or close enough to zero.
        
            estimation = abs(vpa(subs(obj.Equation,symvar(obj.Equation,1),entry)));
            if estimation == 0 || estimation <= obj.Precision
                r = 1;
            else
                r = 0;
            end
            
        end
        
        function r = checkAprxAbsoluteError(obj, entry)
        % This method tests whether the approximation f(entry) is close enough to zero.
        
            estimation = abs(vpa(subs(obj.Equation,symvar(obj.Equation,1),entry)));
            if estimation <= obj.Precision
                r = 1;
            else
                r = 0;
            end
            
        end        
        
    end
    
end



