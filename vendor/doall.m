% blocks
% TESTDATA1/f

% full recognition process
function doall(fig2)

  % basic values
  Dim = 3;            % number of feature properties
  modelfilename = input('Model file name (filename)\n?','s');
  maxclasses = input('Number of classes (int)\n?');

  % do any training
  user_entry = input('Want to acquire training data (0,1)\n?');
  if user_entry == 1
        trainfilestem = input('Training image file stem (filestem)\n?','s');
        livedata = input('Use live training data (0,1)\n?');
        N = input('Number of training images (int)\n?');
        vecs = zeros(N,Dim);
        trueclasses = zeros(N,1);
        for imagenum = 1 : N

             % get image data
             if livedata == 1
               currentimagergb = liveimagejpg([trainfilestem,int2str(imagenum),'.jpg']);
             else
               currentimagergb = imread([trainfilestem,int2str(imagenum),'.jpg'],'jpg');
             end
             currentimage = rgb2gray(currentimagergb);

	     if fig2 > 0
	       figure(fig2)
	       colormap(gray)
	       imshow(currentimage)
	     end

	     % extract properties
	     vec(imagenum,:) = extractprops(currentimage,0,0,0,0,0);
%	     vec(imagenum,:) = extractprops(currentimage,8,9,10,11,12);
	
	     % get true class for scatter matrix
	     trueclasses(imagenum) = input(['Train image ',int2str(imagenum),' true class (1..',int2str(maxclasses),')\n?']);
        end
        [Means,Invcors,Aprioris] = buildmodel(Dim,vec,N,maxclasses,trueclasses);

        % save training data        
        eval(['save ',modelfilename,' maxclasses Means Invcors Aprioris'])
  end

  % load class data
  eval(['load ',modelfilename,' maxclasses Means Invcors Aprioris'])

  % see if using live data
  livedata = input('Want to use live test data (0,1)\n?');
  imagestem = input('Test image file stem (filestem)\n?','s');

  % recognition phase
  run=1;
  imagenum=0;
  scatter = zeros(maxclasses,maxclasses);
  while ~(run == 0)
     imagenum = imagenum + 1;
     if livedata == 1
       currentimagergb = liveimagejpg([imagestem,int2str(imagenum),'.jpg']);
     else
       currentimagergb = imread([imagestem,int2str(imagenum),'.jpg'],'jpg');
     end
     currentimage = rgb2gray(currentimagergb);

     if fig2 > 0
       figure(fig2)
       colormap(gray)
       imshow(currentimage)
     end

     % extract properties
%     vec = extractprops(currentimage,3,4,5,6,7);
     vec = extractprops(currentimage,0,0,0,0,0);
     
     % get true class for scatter matrix
     trueclass=input(['true class (1..',int2str(maxclasses),')\n?']);
     
     % classification
     class = classify(vec,maxclasses,Means,Invcors,Dim,Aprioris)
     scatter(trueclass,class) = scatter(trueclass,class) + 1;

     run = input(['Want to process another image ',int2str(imagenum+1),' (0,1)\n?']);
  end

  ['scatter matrix (rows are true, cols are classified)']
  scatter

  
