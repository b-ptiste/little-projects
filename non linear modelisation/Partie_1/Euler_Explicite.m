function [Y,temps] = Euler_Explicite(b,c,Y0,T,dt)
  tic
  Y = [Y0(1),Y0(2),Y0(3)];
  
  for i = 1:(T/dt)
    yn = Y(i,:)' ;  % on prend toute la ligne.
    yn = yn+dt*f1(yn,b,c) ;
    Y = [Y;yn'] ; 
  endfor
  
  temps = toc ; 
  
endfunction
