function visualturn(old, new, dimension)

a = old(dimension) - new(dimension)
c = sqrt((old(1) - new(1))^2 + (old(2) - new(2))^2)

alpha = acos(c / a);
v = 10;



vl = v * (1 + (alpha - 1.5 * pi) / (0.5 * pi));
vr = v * (1 + alpha / (0.5 * pi));

drivebot(vl, vr, 0.5);

end %  function