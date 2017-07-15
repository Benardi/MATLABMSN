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
        
        
        function r = extractPolynomDegree(self, polyn)
               r = length(sym2poly(polyn))- 1;
        end
        
        function r = highestDegree(self)
            max = 0;
            for equ = self.EquationsMatrix
                temp = self.extractPolynomDegree(equ);
                if( temp > max)
                    max = temp;
                end
            end
            r = max;
        end
        
       function r = createBaseMatrix(self)
           r = zeros(length(self.EquationsMatrix), self.highestDegree() + 1);
       end
       
       function r = buildsLinearSystem(self)
            baseMatrix = self.createBaseMatrix();

            for row = 1: size(baseMatrix, 1)
                currentEqu = sym2poly(self.EquationsMatrix(row));
                diffSize = length(baseMatrix) - length(currentEqu);
                display(baseMatrix)

                for i = 1:length(currentEqu)
                    baseMatrix(row,diffSize + i) = currentEqu(1,i);
                end   
            end
            r = baseMatrix;
       end
       
    end
    
end

