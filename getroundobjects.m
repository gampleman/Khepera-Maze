function object_coords = getroundobjects(bw, threshold)
%   GETROUNDOBJECTS   Short description
%     [OBJECT_COORDS] = GETROUNDOBJECTS(I, THRESHOLD)
% 
%   Long description
%   
%   Created by Jakub Hampl on 2010-11-08.



% remove all object containing fewer than 30 pixels
bw = bwareaopen(bw,30);

% fill a gap in the pen's cap
%se = strel('disk',2);
%bw = imclose(bw,se);

% fill any holes, so that regionprops can be used to estimate
% the area enclosed by each of the boundaries
%bw = imfill(bw,'holes');

[B,L] = bwboundaries(bw,'noholes');

% Display the label matrix and draw each boundary
%for k = 1:length(B)
%  boundary = B{k};
%  plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2)
%end

stats = regionprops(L,'Area','Centroid');


object_coords = zeros(3, 4);


% loop over the boundaries
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
    if area > min(areas)
      [v, index] = min(areas);
      object_coords(:, index) = [centroid(2), centroid(1), area];
    end
  end
end
  
  
  object_coords = object_coords(1:2, :);
  new_object_coords = zeros(2, 4);
  % top
  [v, index] = min(object_coords(2, :));
  new_object_coords(:, 1) = object_coords(:, index);
  % right
  [v, index] = max(object_coords(1, :));
  new_object_coords(:, 2) = object_coords(:, index);
  % bottom
  [v, index] = max(object_coords(2, :));
  new_object_coords(:, 3) = object_coords(:, index);
  % left
  [v, index] = min(object_coords(1, :));
  new_object_coords(:, 4) = object_coords(:, index);
  
  object_coords = new_object_coords';
end %  function