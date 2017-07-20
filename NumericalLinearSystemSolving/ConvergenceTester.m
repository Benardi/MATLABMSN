classdef ConvergenceTester
    %CONVERGENCETESTER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        systemBuilder % aux object that creates a system
    end
    
    methods
        function obj = ConvergenceTester(matrix)
            obj.systemBuilder = LinearSystemBuilder(matrix);
        end
        
        function r = sassenfeldCriterion(self)
            r = 0;
            numVariables = length(self.systemBuilder.getAllVariables());
            system = self.systemBuilder.createSystem();
            system = system(:,1:end -1);
            Bs = ones(numVariables, 1);
            
            for i=1:numVariables
            pivot = 1/system(i,i);
            system(i,i) = 0;
            Bs(i) = (abs(system(i,:)) * pivot) * Bs;     
            end
            
            if (max(Bs) < 1)
                r = 1;
            else
                r = 0;
            end
            
        end
        
        function r = lineCriterion(self)
            system = self.systemBuilder.createSystem();
            system = system(:,1:end -1);
            r = 1;
            for i =1:size(system,1)
                row = system(i,:);
                pivot = row(i);
                row(i) = 0;
                S = sum(abs(row));
                if (pivot <= S)
                    r = 0;
                    break;
                end
            end

        end
    end
    
end