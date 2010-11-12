function not_free = scanline(I, lineindex, robot_size, dimension)
[a h] = size(I);
margin = 40;
a = a - margin;
if dimension == 2
  free_after = sum(I(margin:a, round(lineindex + robot_size))) == 0;
  free_before = sum(I(margin:a, round(lineindex - robot_size))) == 0;
else
  free_after = sum(I(round(lineindex + robot_size), margin:a)) == 0;
  free_before = sum(I(round(lineindex - robot_size), margin:a)) == 0;
end
not_free = ~(free_before && free_after);
end % function
