function [y_dot] = f(a,b,c,y)

  y_dot1 = -b*y(1)*y(2)-a*y(1) ;
  y_dot2 = b*y(1)*y(2)-c*y(2) ; 
  y_dot3 = c*y(2) ; 
  y_dot4 = a*y(1) ; 
  
  y_dot = [y_dot1;y_dot2;y_dot3;y_dot4] ; 
  
endfunction
