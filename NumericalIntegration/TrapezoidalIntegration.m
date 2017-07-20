classdef TrapezoidalIntegration
    %TRAPEZOIDALINTEGRATION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Equation
    end
    
    methods
        function self = TrapezoidalIntegration(equation)
            self.Equation = equation;
        end
        
        function r = simpleTrapezoidalRule(self,a,b)
            h = b - a;
            t = subs(self.Equation, symvar(self.Equation, 1), b);
            T = subs(self.Equation, symvar(self.Equation, 1), a);
            r = vpa((h/2) * (t + T));
        end
    end
    
end

