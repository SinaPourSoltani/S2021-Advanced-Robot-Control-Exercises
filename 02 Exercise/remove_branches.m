function trimmed_path = remove_branches(path,step)
i = 2;
trimmed_path = path;
while i < size(trimmed_path,1)
    if norm(trimmed_path(i-1,:) - trimmed_path(i+1,:)) < step
        trimmed_path = [trimmed_path(1:i-1,:); trimmed_path(i+1:end,:)];
        if i > 2
            i = i - 1;
        end
    else
        i = i + 1;
    end
end
end

