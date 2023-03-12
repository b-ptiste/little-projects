# fonction 1 pour la première partie

# b --> beta
# c --> gamma
#
#     S
# y = I
#     R

function [y_dot] = f1(y,b,c)
  
  # calcule de la valeur
  
  y_dot1 = -b*y(1)*y(2) ;
  y_dot2 = b*y(1)*y(2)-c*y(2) ;
  y_dot3 = c*y(2) ;
  
  y_dot = [y_dot1;y_dot2;y_dot3];
 
endfunction
