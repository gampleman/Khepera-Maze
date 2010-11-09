function Image = mymorph(img, varargin)
  Image = img;
  for i = 1:length(varargin)
    Image = bwmorph(Image, varargin(i));
  end

end %  function