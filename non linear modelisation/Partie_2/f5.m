function [y_dot] = f5(a,b,c,d,e,f,y)
  # a : taux de vaccination
  # b : taux de transmissibilité
  # c : taux de retablissement
  # d : retabli vers sain
  # e : taux de mort du au virus
  # f : efficacité du vaccination

  y_dot1 = -b*y(1)*y(2)-a*y(1)+d*y(3)+f*y(4); # S
  y_dot2 = b*y(1 )*y(2)-c*y(2)-e*y(2) ; # I
  y_dot3 = c*y(2)-d*y(3) ; # R
  y_dot4 = a*y(1)-f*y(4) ; # V 
  y_dot5 = e*y(2); # M
  
  
  y_dot = [y_dot1;y_dot2;y_dot3;y_dot4;y_dot5] ; 
  
  
  
endfunction