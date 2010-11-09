% computes the probability density of a test feature vector Vec
% and a test class with mean vector Mean and inverse covariance
% matrix Invcor assuming a multi-variate gaussian distribution
% It also weights by the class's a priori probability.
% You need to normalize by p(x)=sum(p(x|c)*p(c)) over all classes c
% to turn these numbers into true probabilities p(c|x).
function prob = multivariate(Vec,Mean,Invcor,apriori)

        diff = Vec-Mean;
        dist = diff*Invcor*diff';
        n = length(Vec);
        wgt = 1/sqrt(det(inv(Invcor)));
        prob = apriori * ( 1 / (2*pi)^(n/2) ) * wgt * exp(-0.5*dist);

        
        

