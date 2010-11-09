function Image = clearImage(input, varargin)
  
  if length(varargin) == 2
    [thresh1 thresh2] = varargin(:);
  else
    thresh1 = 0.43;
    thresh2 = 0.22;
  end
  
  Image = ~im2bw(rgb2gray(input), thresh1) - ~im2bw(rgb2gray(input), thresh2);

end %  function