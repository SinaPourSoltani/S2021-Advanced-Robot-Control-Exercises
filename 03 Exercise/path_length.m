function l = path_length(steps)
l = 0;
for i = 1:1:size(steps,1)-1
    l = l + (norm(steps(i+1,:) - steps(i,:)));
end
end

