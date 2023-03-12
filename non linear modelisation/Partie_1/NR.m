% méthode de Newton pour appliquer
% la méthode Euler_Implicite


function [x] = NR(yn,b,c,x0,tol,itmax,dt)

  x = x0 ;
  it = 0;
  
  [val,J] = f2(x,yn,b,c,dt);
  
  % pour l'erreur à chaque étape, 
  % on regarde la somme des composantes (norme 1)
  err = sum(abs(val));
  
  while (it<itmax && err>tol)
    ++it ;
    x = x-inv(J)*val ;
    [val,J] = f2(x,yn,b,c,dt) ;
    err = sum(abs(val)) ;
  endwhile
  
  
  if (it==itmax)
    printf("convergence non atteinte\n")
  endif
  
  
  
  
  
endfunction
