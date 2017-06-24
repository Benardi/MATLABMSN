classdef ConvergenceTester
    %CONVERGENCETESTER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Equation
        Precision
    end
    
    methods
        function obj = ConvergenceTester(equation, precision)
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
        
        function r = testIntervalBisection(self, a, b, disable)
            if disable == 1
                r = 1;
            else
                if self.testIntervalContinuity(a,b, self.Equation) == 0 || ...
                        self.testHypothesis(a,b) == 0 || self.testTheorem1(a,b) == 0
                    r = 0;
                else
                    r = 1;
                end
            end
        end
        
        function r = testIntervalforNewton(self, a, b,x0, disable)
            if disable == 1
                r = 1;
            else
                f = self.Equation;
                f1 = diff(f);
                f2 = diff(f1);
                if self.testIntervalContinuity(a, b, f) == 0 || ...
                        self.testIntervalContinuity(a, b, f1) == 0 || ...
                        self.testIntervalContinuity(a, b, f2) == 0 || ...
                        self.testTheorem1(a,b) == 0 || ...
                        self.testHypothesis(a,b) == 0 || x0 < a || x0 > b
                    r = 0;
                else
                    r = 1;
                end
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

