classdef Milestone
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        State = []
        
    end
    
    methods
        function obj = Milestone(state)

            obj.State = state;
        end
        
        function dist = distance(milestone1, milestone2)
            state1 = milestone1.State; 
            state2 = milestone2.State; 
            dist = sum((state1-state2).^2);
        end
    end
end

