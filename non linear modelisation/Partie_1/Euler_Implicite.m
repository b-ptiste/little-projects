function [Y,temps] = Euler_Implicite(b,c,Y0,T,dt,itmax,tol)
  tic
  Y = [Y0(1),Y0(2),Y0(3)] ;

  for i = 1:(T/dt)
    
    yn = Y(i,:)' ;  % on prend toute la ligne.
    
    % on lance NR depuis y_n pour trouver y_n+1
    yn = NR(yn,b,c,yn,tol,itmax,dt);
    Y = [Y;yn'] ;
    
  endfor
  
  temps = toc ; 
  
endfunction
