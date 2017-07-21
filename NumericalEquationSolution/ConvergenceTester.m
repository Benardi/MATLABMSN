classdef ConvergenceTester
    % CONVERGENCETESTER Class that proves convergence of a method.
    % Convergence is proven for an equation at a given interval.

    
    properties
        Equation  % Equation on which a method is being employed.
    end
    
    methods
        function obj = ConvergenceTester(equation)
            if nargin > 0
                if strcmp(class(equation),'sym') == 0
                    error('Insert a symbolic function')
                else
                    obj.Equation = equation;
                end
            end
        end
        
        function r = testIntervalBisection(self, a, b, disable)
        % This method tests whether convergence can be guaranteed
        % for the bisection method at a given interval.
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
        % This method tests whether convergence can be guaranteed
        % for Newton-Raphson method at a given interval.
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
    end
    
    methods (Access = private)
        function r = testTheorem1(obj, a, b)
        % This methods tests whether there's some root at a given interval.
        % The method compares if f(a) * f(b) < 0. 
            r = 1;
            equ = obj.Equation;
            
            if vpa(subs(equ,symvar(equ,1),a)) * vpa(subs(equ,symvar(equ,1),b)) > 0
                r = 0;
                
            end
            
            
        end
        
        function r = testHypothesis(obj, a, b)
        % This methods tests whether there's one root at a given interval.
        % The method compares if f'(a) * f'(b) > 0. 
        % This method is only significant if  Theorem 1 is true.
            r = 1;
            f = diff(obj.Equation);
            
            if vpa(subs(f,symvar(f,1),a)) * vpa(subs(f,symvar(f,1),b)) < 0
                r = 0;
            end
        end
        
        
        function r = testIntervalContinuity(obj, a , b, equation)
        % This methods tests whether there's discontinuity at a given interval.
        % The method checks if any found discontinuity lies between a and b. 
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

