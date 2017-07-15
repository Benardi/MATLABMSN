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
            variables = self.getAllVariables();
            temp = 1;
            for elem = variables
                temp = temp +elem;
            end
            r = coeffs(temp + polynom);
            r = r - 1;
            r = single(r);
            temp = r(1);
            r(1) = [];
            r = [r temp];
            
        end
        
        function r = createSystem(self)
            r = [];
            for equ = self.EquationsMatrix
                r = [r; self.getCoefficients(equ)];
            end
        end     
    end
    
end

