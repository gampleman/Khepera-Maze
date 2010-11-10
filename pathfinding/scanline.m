function free = scanline(I, lineindex)
[a h] = size(I);
a = a - 40;
free = sum(I(40:a, lineindex)) == 0;

end % function
