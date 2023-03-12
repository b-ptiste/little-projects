% comparaison des temps de calcules.
clear all
close all

dT = [1:0.2:5] ;
T = 1200;
b = 1;
c = 0.005;
tol = 10^(-4);
itmax = 200000;
Y0 = [0.9;0.1;0]; % condition initiale


temps_EI = [];
temps_EE = [];


for dt = dT
  [y_i,tps_EI] = Euler_Implicite(b,c,Y0,T,dt,itmax,tol) ;
  [y_e , tps_EE] = Euler_Explicite(b,c,Y0,T,dt) ;
  
  temps_EI = [temps_EI,tps_EI];
  temps_EE = [temps_EE,tps_EE];
  
endfor
%


figure(1)
  hold on
  scatter(dT,temps_EI,'r')
  scatter(dT,temps_EE,'b')
  legend('temps EI','temps EE')
  xlabel('\Delta t')
  ylabel('temps (s)')
  title('comparaison des temps de calcul')