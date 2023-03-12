clear all
close all
% scénario de vaccination.

T = 80;
dt = 1;

I = [0:dt:T];
Y0 = [0.8,0.2,0,0];

Y = [Y0];

% paramètres
b = 0.4 ;
c = 0.1 ;
a = 0;

for i = 1:(T/dt)
  
  yn = Y(i,:)';
  
  if(i<6/dt)
    a = 0;
  else
    % debut de la vaccination
    a = 0.1;
  endif
  
  yn = yn+dt*f(a,b,c,yn) ;
  
  Y = [Y;yn'] ;

endfor
%



% graphiques
figure(1)
  hold on
  plot(I,Y(:,1),'k')
  plot(I,Y(:,2),'r')
  plot(I,Y(:,3),'g')
  plot(I,Y(:,4),'b')
  title('modèle de vaccination pour \Delta t = 1')
  xlabel('temps (en jour)')
  ylabel('evolution des population en %')
  plot(6,[0:0.01:1],'k')
  legend('S','I','R','V')
