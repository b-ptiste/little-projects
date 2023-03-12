clear all
close all
% scénario de confinement+vaccination.

T = 80;
dt = 0.1;

I = [0:dt:T];
Y0 = [0.8,0.2,0,0];
Y = [Y0];

% paramètres
b = 0.4 ;
c = 0.1 ;
a = 0;

for i = 1:(T/dt)
  yn = Y(i,:)';
  
  % confinement
  if(i<=15/dt && i>=5/dt)
    b = 0.1;
  else 
    b = 0.4;
  endif
  
  % vaccination
  if(i<6/dt)
    a = 0;
  else 
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
  plot(I,Y(:,3),'b')
  plot(I,Y(:,4),'g')

  plot(5,[0:0.01:1],'k')
  plot(15,[0:0.01:1],'k')
  plot(6,[0:0.01:1],'m')
  legend('S','I','R','V')

  title('confinement+vaccination pour \Delta t=1')
  xlabel('temps (en jour)')
  ylabel('evolution des populations en %')