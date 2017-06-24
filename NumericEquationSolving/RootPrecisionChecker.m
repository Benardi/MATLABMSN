classdef RootPrecisionChecker
    %NUMERICALEQUATIONSOLVER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Equation
        Precision
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
        
        % tests whether function at estimated point or relative
        % error is at an acceptable level of precision
        function r = testTolerance(obj, entry, previous)
            relativeError = abs((entry - previous)/entry);
            estimation = abs(vpa(subs(obj.Equation,symvar(obj.Equation,1),entry)));
            if estimation <= obj.Precision || relativeError <= obj.Precision
                r = 1;
            else
                r = 0;
            end
            
        end
        % tests whether function at estimated point is exact root
        function r = testExactMatch(obj, entry)
            estimation = abs(vpa(subs(obj.Equation,symvar(obj.Equation,1),entry)));
            if estimation == 0
                r = 1;
            else
                r = 0;
            end
            
        end
    end
    
end



