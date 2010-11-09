% build model mean feature vector (Mean) and inverse of covariance matrices
% (Invcors) for Numclass classes given a set of N classified (Classes) observed
% feature vectors (Vecs) of Dim dimension
function [Means,Invcors,Aprioris] = buildmodel(Dim,Vecs,N,Numclass,Classes)

    Means = zeros(Numclass,Dim);
    Invcors = zeros(Numclass,Dim,Dim);
    for i = 1 : Numclass

        % get means for class i
        samples = find(Classes == i);
        M = length(samples);       % number of observations
        if M < 2
            ['Error: class ',int2str(i),' has insufficient data']
            Means(i,:) = zeros(1,Dim);
            Invcors(i,:,:) = zeros(Dim,Dim);
            for j = 1 : Dim
              Invcors(i,j,j) = 1;
            end
        else
            classvecs = Vecs(samples,:);
            mn = mean(classvecs);
            Means(i,:) = mn;
            diffs = classvecs - ones(M,1)*mn;
            Invcors(i,:,:) = inv(diffs'*diffs/(M-1));
        end
        Aprioris(i)=M/N;
    end

