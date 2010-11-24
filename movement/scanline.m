function not_free = scanline(I, lineindex, robot_size)
% NOT_FREE = SCANLINE(INPUT_IMAGE, COLUMN, SPACE_REQUIRED)
%  Scans the center region of the image if the SPACE_REQUIRED number of columns
%  around COLUMN are free of obstacles.
[w h] = size(I);

margin = 32;
a = w - margin;
free_after = sum(I(margin:a, round(lineindex + robot_size))) == 0;
free_before = sum(I(margin:a, round(lineindex - robot_size))) == 0;

not_free = ~(free_before && free_after);
end % function
