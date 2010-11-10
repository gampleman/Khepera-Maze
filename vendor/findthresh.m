% find a threshold from a histogram by smoothing with a gaussian with
% standard deviation sigma and find the low valley location
% sizeparam should be at least 4, with larger giving less smoothing
function thresh = findthresh(thehist,sizeparam,show)

  [len,x] = size(thehist);

  % convolve with a gaussian smoothing window here
  filterlen = 50;                               % filter length
  thefilter = mygausswin(filterlen,sizeparam);
  thefilter = thefilter/sum(thefilter);                  % normalize
  tmp2=conv(thefilter,thehist);               
  tmp1=tmp2(1+filterlen/2:len+filterlen/2);     % select corresponding portion
  if show > 0
     figure(show)
     clf
     plot(tmp1)
  end

  % find largest peak
  peak = find(tmp1 == max(tmp1));
  
  % find highest peak to left
  xmaxl = -1;
  pkl = -1;
  for i = 2 : peak-1
    if tmp1(i-1) < tmp1(i) & tmp1(i) >= tmp1(i+1)
      if tmp1(i) > xmaxl
        xmaxl = tmp1(i);
        pkl = i;
      end 
    end
  end
  if pkl == -1
    pkl = 1;
    xmaxl = 1;
  end
%    [pkl,xmaxl]

  % find deepest valley between peaks
  xminl = max(tmp1)+1;
  vall = -1;
  for i = pkl+1 : peak-1
    if tmp1(i-1) > tmp1(i) & tmp1(i) <= tmp1(i+1)
      if tmp1(i) < xminl
        xminl = tmp1(i);
        vall = i;
      end
    end
  end
  if vall == -1
    vall = 2;
    xminl = 2;
  end
%    [vall,xminl]

  % find highest peak to right
  xmaxr = -1;
  pkr = -1;
  for i = peak+1 : len-1
    if tmp1(i-1) < tmp1(i) & tmp1(i) >= tmp1(i+1)
      if tmp1(i) > xmaxr
        xmaxr = tmp1(i);
        pkr = i;
      end 
    end
  end
  if pkr == -1
    pkr = len;
    xmaxr = 1;
  end
%    [pkr,xmaxr]

  % find deepest valley between peaks
  xminr = max(tmp1)+1;
  valr = -1;
  for i = peak+1 : pkr-1
    if tmp1(i-1) > tmp1(i) & tmp1(i) <= tmp1(i+1)
      if tmp1(i) < xminr
        xminr = tmp1(i);
        valr = i;
      end
    end
  end
  if valr == -1
    valr = len-1;
    xminr = 2;
  end
%    [valr,xminr]

  % find lowest point between peaks
  if xmaxr > xmaxl
      thresh = valr;
  else
      thresh = vall;
  end


  thresh = thresh-1;    % subtract 1 as histogram bin 1 is for value 0
