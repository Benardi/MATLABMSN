classdef NumericalEquationSolver
    %NUMERICALEQUATIONSOLVER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Equation
        Precision
        a
        b
    end
    
    methods
        function obj = NumericalEquationSolver(equation, precision)
            if nargin > 0
                if strcmp(class(equation),'sym') == 1 
                    obj.Equation = equation;
                    obj.Precision = precision;
                else
                    error('Insert a symbolic function')
                end
            end
        end
        
        function self = setInterval(self, a, b)
            if self.testIntervalContinuity(a,b) == 0      
                error('Interval contains descontinuity')
                
            elseif self.testTheorem1(a,b) == 0
                error('Interval violates Theorem1')

            elseif self.testHypothesis(a,b) == 0
                error('Interval violates Hypothesis')
            else
                self.a = a;
                self.b = b;
            end
        end
           
        function r = defineNewInterval(obj, xk)
             if obj.testTheorem1(obj.a, xk) == 1
                 obj.b = xk;
                 
             else
                 obj.a = xk;
             end
               r = obj;  
        end  
        
        function r = testCandidate(obj, entry)
            estimation = abs(vpa(subs(obj.Equation,symvar(obj.Equation,1),entry)));
            if estimation <= obj.Precision
                r = 1;
            else
                r = 0;
            end    
            
        end
        
        function r = testTheorem1(obj, a, b)
            r = 1;
            equ = obj.Equation;
            
            if vpa(subs(equ,symvar(equ,1),a)) * vpa(subs(equ,symvar(equ,1),b)) > 0
                r = 0;
                
            end
        
        
        end
        
        function r = testHypothesis(obj, a, b)
            r = 1;
            f = diff(obj.Equation);
            
            if vpa(subs(f,symvar(f,1),a)) * vpa(subs(f,symvar(f,1),b)) < 0
                r = 0;
            end
        end
                 
        
        function r = testIntervalContinuity(obj, a , b)
            r = 1;
            disc = feval(symengine, 'discont', obj.Equation, symvar(obj.Equation, 1));
            for val = disc
                if (val == a || val ==b || (val > a && val < b))
                    r = 0;
                    
                end
            end 
        end
    end
           
end
    


