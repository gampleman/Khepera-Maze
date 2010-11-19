function object_coords = getroundobjects(bw, threshold)
%GETROUNDOBJECTS Retun an array with the round objects coordinates.
%
%   [OBJECT_COORDS] = GETROUNDOBJECTS(I, THRESHOLD) Takes an image and 
%   returns an array with the coordinates of the center of the round 
%   objects. An object is classified as a round object by a given threshold.

% remove all object containing fewer than 30 pixels
bw = bwareaopen(bw,30);

% fill a gap 
%se = strel('disk',2);
%bw = imclose(bw,se);

% fill any holes, so that regionprops can be used to estimate
% the area enclosed by each of the boundaries
%bw = imfill(bw,'holes');

[B,L] = bwboundaries(bw,'noholes');
stats = regionprops(L,'Area','Centroid');
object_coords = zeros(3, 1);

i = 1;
for k = 1:length(B)

  % obtain (X,Y) boundary coordinates corresponding to label 'k'
  boundary = B{k};

  % compute a simple estimate of the object's perimeter
  delta_sq = diff(boundary).^2;
  perimeter = sum(sqrt(sum(delta_sq,2)));

  % obtain the area calculation corresponding to label 'k'
  area = stats(k).Area;

  % compute the roundness metric
  metric = 4*pi*area/perimeter^2;


  % mark objects above the threshold with a black circle
  if metric > threshold
    areas = object_coords(3, :);
    centroid = stats(k).Centroid;
    [a b] = size(object_coords);
    object_coords(:, i) = [centroid(2), centroid(1), area];
    i = i + 1;
  end
end

end %  function


