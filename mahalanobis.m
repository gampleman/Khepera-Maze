% computes the Mahalanobis distance of a test feature vector Vec
% and a test class with mean vector Mean and inverse covariance
% matrix Invcor
function dist = mahalanobis(Vec,Mean,Invcor)

        diff = Vec-Mean;
        dist = diff*Invcor*diff';

