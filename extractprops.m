% extract the properties from a given grey level image
% fig4/5/6/7 are either 0 or a figure number for results display
function vec = extractprops(image,fig3,fig4,fig5,fig6,fig7)

     hist = dohist(image,fig3);                 % histogram image
     thresh = findthresh(hist,4,fig4);          % find threshold
     binimage = ~im2bw(image,thresh/255);       % do thresholding

     if fig5 > 0
       figure(fig5)
       colormap(gray)
       imshow(binimage)
     end

     largestimage = getlargest(binimage,fig6);          % get biggest region
     cleanimage = cleanup(largestimage,2,2,fig7);       % clean up region
     vec = getproperties(binimage);                     % calculate properties
