% computes the histogram of a given image into num bins.
% values less than 0 go into bin 1, values bigger than 255
% go into bin 255
% if show=0, then don't show. Otherwise show in figure(show)
function thehist = dohist(theimage,show)

  % set up bin edges for histogram
  edges = zeros(256,1);
  for i = 1 : 256;
    edges(i) = i-1;
  end

  [R,C] = size(theimage);
  imagevec = reshape(theimage,1,R*C);      % turn image into long array
  thehist = histc(imagevec,edges)';        % do histogram
  if show > 0
      figure(show)
      clf
      pause(0.1)
      plot(edges,thehist)
      axis([0, 255, 0, 1.1*max(thehist)])
  end
