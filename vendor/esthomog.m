% estimate homography matrix P from N matched points UV(N:2) -> XY(N:2)
% Based on Hartley & Zisserman's description of the DLT algorithm
function P=esthomog(UV,XY,N)

  % set up A matrix for 0=Ap
  A=zeros(2*N,9);
  for i = 1 : N
    A(2*i-1,:)=[0,0,0,-UV(i,1),-UV(i,2),-1,XY(i,2)*UV(i,1),XY(i,2)*UV(i,2),XY(i,2)]';
    A(2*i,:)=[UV(i,1),UV(i,2),1,0,0,0,-XY(i,1)*UV(i,1),-XY(i,1)*UV(i,2),-XY(i,1)]';
  end

  % get eigenvector of smallest eigenvalue
  [U,D,V]=svd(A);
  p = V(:,9);
  p = p / norm(p);      % normalise to unit length

  % pack back into matrix
  P=[[p(1),p(4),p(7)]',[p(2),p(5),p(8)]',[p(3),p(6),p(9)]'];
