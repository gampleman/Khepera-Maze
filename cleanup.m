% does a variety of morphological operations to clean up
% thresholded image. Erodes ERO times to remove dangling pixels.
% Dilates ERO to reverse and then DIL more to fill internal holes.
% Erodes DIL to restore size.
function BW2 = cleanup(binimage,ERO,DIL,show)

     SE = strel('square',3);        % structuring element
     BW2 = binimage;
     for i = 1 : ERO
       BW1 = BW2;
       BW2 = imerode(BW1,SE);       % remove spurs
     end
     for i = 1 : DIL+ERO
       BW1 = BW2;
       BW2 = imdilate(BW1,SE);      % restore and fill internal holes
     end
     for i = 1 : DIL
       BW1 = BW2;
       BW2 = imerode(BW1,SE);       % restore size
     end

     if show > 0
        figure(show)
        colormap(gray)
        imshow(BW2)
     end

