%% getcorners: no function description!
function corners = getcorners(bw, threshold)

round_objects = getroundobjects(bw, threshold);
round_objects = round_objects';

round_objects(:, 3) = sqrt(round_objects(:, 3) / pi);

[a,index] = sort(round_objects(:,3), 1, 'descend');
corners = round_objects(index(1:4), :);

corners = corners(:,(1:2));
