% c'est la fonction à annuler dans notre Euler Implicite.


function [val,J] = f2(u,yn,b,c,dt)
  
  % fonction que on doit annuler
  val = u-yn-dt*f1(u,b,c) ; 
  
  % matrice jacobienne
  Jf = [-dt*b*u(2),-dt*b*u(1),0;dt*b*u(2),dt*b*u(1)-dt*c,0;0,dt*c,0] ; 
  J = eye(3)-Jf ;
  
endfunction
