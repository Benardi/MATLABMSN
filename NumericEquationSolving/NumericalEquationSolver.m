classdef NumericalEquationSolver
    %NUMERICALEQUATIONSOLVER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Equation
        LeftEndPoint
        RightEndPoint
    end
    
    methods
        function obj = NumericalEquationSolver(equation)
            if nargin > 0
                if strcmp(class(equation),'sym') == 1 
                    obj.Equation = equation;
                else
                    error('Insert a symbolic function')
                end
            end
        end
        
        function r = testInterval(obj)
            r = feval(symengine, 'discont', obj.Equation, symvar(obj.Equation, 1));
        end
            
    end
    
end

