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
        
        function self = setInterval(self, a, b)
            if self.testInterval(a,b) == 1
                self.LeftEndPoint = a;
                self.RightEndPoint = b;
            else
                error('Interval contains descontinuity')
            end
        end
        
        function r = testInterval(obj, a , b)
            r = 1;
            disc = feval(symengine, 'discont', obj.Equation, symvar(obj.Equation, 1));
            for val = disc
                if (val == a || val ==b || (val > a && val < b))
                    r = 0;
                    
                end
            end
            
            equ = obj.Equation;
            f = diff(equ);
            
            if vpa(subs(equ,symvar(equ,1),a)) * vpa(subs(equ,symvar(equ,1),b)) > 0
                r = 0;
            end
            
            if vpa(subs(f,symvar(f,1),a)) * vpa(subs(f,symvar(f,1),a)) < 0
                r = 0;
            end
                    
                    
        end
            
    end
    
end

