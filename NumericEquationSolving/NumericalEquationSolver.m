classdef NumericalEquationSolver
    %NUMERICALEQUATIONSOLVER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Equation
        Precision
    end
    
    methods
        function obj = NumericalEquationSolver(equation, precision)
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
        
        function self = testIntervalBissection(self, a, b)
            if self.testIntervalContinuity(a,b, self.Equation) == 0      
                error('Equation contains descontinuity at interval')
                
            elseif self.testTheorem1(a,b) == 0
                error('f(a)f(b) > 0')

            elseif self.testHypothesis(a,b) == 0
                error('First Derivative doesn''t preserve signal at interval')
            end
        end
        
        function r = testFurtherDivergence(self, previous, current)
            equ = self.Equation;
            fPrevious = vpa(subs(equ,symvar(equ,1),previous));
            fCurrent = vpa(subs(equ,symvar(equ,1),current));
            
            if fPrevious > fCurrent
                r = 0;
            else
                r = 1;
            end
        end
        
        function r = testIntervalforNewton(self, a, b,x0)
            f = self.Equation;
            f1 = diff(f);
            f2 = diff(f1);
            if self.testIntervalContinuity(a, b, f) == 0 
                error('Equation contains descontinuity at interval')
            elseif self.testIntervalContinuity(a, b, f1) == 0
                r = 0;
            elseif self.testIntervalContinuity(a, b, f2) == 0
                r = 0;
            elseif self.testTheorem1(a,b) == 0
                error('f(a)f(b) > 0')
            elseif self.testHypothesis(a,b) == 0
                error('First Derivative doesn''t preserve signal at interval')
            elseif x0 < a || x0 > b
                r = 0;
            else
                r = 1;
            end
        end   
        
        function r = benchmarkTest(obj, entry, previous)
            relativeError = abs((entry - previous)/entry); 
            estimation = abs(vpa(subs(obj.Equation,symvar(obj.Equation,1),entry)));
            if estimation <= obj.Precision || estimation == 0 || relativeError <= obj.Precision
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
                 
        
        function r = testIntervalContinuity(obj, a , b, equation)
            r = 1;
            disc = feval(symengine, 'discont', equation, symvar(obj.Equation, 1));
            for val = disc
                if (val == a || val ==b || (val > a && val < b))
                    r = 0;
                    
                end
            end 
        end
    end
           
end
    


