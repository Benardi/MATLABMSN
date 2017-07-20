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
        
        function r = createsSeriesOfIntervals(self, a,b,numbOfPoints)
            r = [];
            r = [a r];
            for i=1:(numbOfPoints-2)
                intSect = (b * i)/(numbOfPoints-1);
                r = [r intSect];
            end
            r = [r b];

        end
        
        function r = compositeTrapezoidalRule(self,a,b, numbOfPoints)
            interval = self.createsSeriesOfIntervals(a,b,numbOfPoints);
            r = 0;
            for i=1:(length(interval) -1)
                a = interval(i);
                b = interval(i+1);
                localRes = self.simpleTrapezoidalRule(a,b);
                r = r + localRes;
            end
        end
        
        function r = getMaxImageOfFun(self, a, b)
            r = subs(self.Equation, symvar(self.Equation, 1), a);
            interval = linspace(a,b);
            for point = interval
                temp = vpa(subs(self.Equation, symvar(self.Equation, 1), point));
                if temp > r
                    r = temp;
                end
            end
        end
        
        function r = estimatesErrrorAlt(self, a, b, numbOfPoints)
            r = ((numbOfPoints - 1)* ((abs(b - a)/(numbOfPoints - 1))^ 3) * self.getMaxImageOfFun(a, b))/12;
        end

        
        function r = estimatesErrror(self, N, h, a, b)
            r = N * (h ^ 3)* self.getMaxImageOfFun(a, b)/12;
        end
        
        
    end
    
end

