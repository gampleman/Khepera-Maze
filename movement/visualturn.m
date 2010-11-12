function visualturn(old, new, dimension)

a = old(dimension) - new(dimension);
c = sqrt((old(1) - new(1))^2 + (old(2) - new(2))^2);

other_dimension = 3 - dimension;
if dimension == 1
  alpha = pi - acos(a / c);
  if old(other_dimension) < new(other_dimension)
    alpha = alpha * -1;
  end
else
  alpha = acos(a / c);
  if old(other_dimension) > new(other_dimension)
    alpha = alpha * -1;
  end
end
v = 10;

alpha

if abs(alpha) < 0.0873
  alpha = 0;
  v = 20;
end


alpha

vl = v * (1 + alpha / (-0.5 * pi));
vr = v * (1 + alpha / (0.5 * pi));

drivebot(vl, vr, 0.2);

end %  function