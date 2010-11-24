function not_free = scanline(I, lineindex, robot_size, dimension)
[w h] = size(I);


if dimension == 2
  margin = 32;
  a = w - margin;
  free_after = sum(I(margin:a, round(lineindex + robot_size))) == 0;
  free_before = sum(I(margin:a, round(lineindex - robot_size))) == 0;
else
  margin = 60;
  a = h - margin;
  free_after = sum(I(round(lineindex + robot_size), margin:a)) == 0;
  free_before = sum(I(round(lineindex - robot_size), margin:a)) == 0;
end
not_free = ~(free_before && free_after);
end % function
