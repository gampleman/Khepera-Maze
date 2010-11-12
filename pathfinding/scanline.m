function not_free = scanline(I, lineindex, robot_size)
[a h] = size(I);
margin = 40;
a = a - margin;
free_after = sum(I(margin:a, round(lineindex + robot_size))) == 0;
free_before = sum(I(margin:a, round(lineindex - robot_size))) == 0;
not_free = ~(free_before && free_after);
end % function
