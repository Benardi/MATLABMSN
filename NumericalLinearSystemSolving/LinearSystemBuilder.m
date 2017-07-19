classdef LinearSystemBuilder
    %LINEARSYSTEMBUILDER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        EquationsMatrix % the matrix of multiple equations
    end
    
    methods
        function obj = LinearSystemBuilder(matrix)
            obj.EquationsMatrix = matrix;
            
        end
        
        function r = getAllVariables(self)
            r = [];
            for equ = self.EquationsMatrix
                r = [r symvar(equ)];
            end
            r = unique(r);
        end
         
        function r = getCoefficients(self, polynom)
            vars = self.getAllVariables();
            r = [];
            for v = vars
                [cvar, t] = coeffs(polynom, v);
                r = [r cvar(1)];
            end
            b = subs(polynom, vars, zeros(1,length(vars)));
            r = [r -b];
        end
        
        function r = createSystem(self)
            r = [];
            for equ = self.EquationsMatrix
                r = [r; self.getCoefficients(equ)];
            end
        end  
        
        function r = generAprxResults(self, xk)
            r = [];
            xk = xk(:)';
            
            for equ = self.EquationsMatrix
                r = [r vpa(subs(equ, symvar(equ), xk))];
            end
        end
        
    end
    
end

