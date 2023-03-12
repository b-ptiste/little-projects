clear all
close all



%%%%%%%%%%%% Partie test %%%%%%%%%%%%

dt = 1 ;
T = 80 ;
I = [0:dt:T];

% paramètres :
b = 0.8;
c = 0.1;

% condition initiale.
Y0 = [0.9;0.1;0] ;

Y = Euler_Explicite(b,c,Y0,T,dt); 
size(Y)

cum = Y(:,1)+Y(:,2)+Y(:,3);

% graphique
figure(1)
  hold on
  plot(I,Y(:,1),'k')
  plot(I,Y(:,2),'r')
  plot(I,Y(:,3),'g')
  plot(I,cum,'b')
  title('Evolution journalière de la population (\Delta t=1)')
  xlabel('temps (en jour)')
  ylabel('pourcentage de population')
  legend('S','I','R','%cumulé')

%%%%%%%%%%%% Partie grande infectiosité %%%%%%%%%%%%

dt = [1,2,3,4] ;
T = 1200 ;


I1 = [0:dt(1):T];
I2 = [0:dt(2):T];
I3 = [0:dt(3):T];
I4 = [0:dt(4):T];

Y0 = [0.9,0.1,0]; % condition initiale.

% paramètres :
b = 1;
c = 0.005;

Y1 = Euler_Explicite(b,c,Y0,T,dt(1));
Y2 = Euler_Explicite(b,c,Y0,T,dt(2));
Y3 = Euler_Explicite(b,c,Y0,T,dt(3));
Y4 = Euler_Explicite(b,c,Y0,T,dt(4));




% pourcentages cumulé.
cum1 = Y1(:,1)+Y1(:,2)+Y1(:,3);
cum2 = Y2(:,1)+Y2(:,2)+Y2(:,3);
cum3 = Y3(:,1)+Y3(:,2)+Y3(:,3);
cum4 = Y4(:,1)+Y4(:,2)+Y4(:,3);


figure(2)

  % delta t suffisament petit.
  subplot(221)
  hold on
  plot(I1,Y1(:,1),'k')
  plot(I1,Y1(:,2),'r')
  plot(I1,Y1(:,3),'g')
  plot(I1,cum1,'b')
  title('\Delta t =1')
  xlabel('temps (en jour)')
  ylabel('pourcentage de population')
  legend('S','I','R','%cumulé')
  
  
  % oscillations
  subplot(222)
  hold on
  plot(I2,Y2(:,1),'k')
  plot(I2,Y2(:,2),'r')
  plot(I2,Y2(:,3),'g')
  plot(I2,cum2,'b')
  title('\Delta t = 2')
  xlabel('temps (en jour)')
  ylabel('pourcentage de population')
  legend('S','I','R','%cumulé')
  
  %oscillations
  subplot(223)
  hold on
  plot(I3,Y3(:,1),'k')
  plot(I3,Y3(:,2),'r')
  plot(I3,Y3(:,3),'g')
  plot(I3,cum3,'b')
  title('\Delta t = 3')
  xlabel('temps (en jour)')
  ylabel('pourcentage de population')
  legend('S','I','R','%cumulé')
  
  % explosion de la capacité mémoire à cause des oscillations
  
  %subplot(221)
  %hold on
  %plot(I4,Y4(:,1),'k')
  %plot(I4,Y4(:,2),'r')
  %plot(I4,Y4(:,3),'g')
  %plot(I4,cum4,'b')
  %title('\Delta t =4')
  %xlabel('temps (en jour)')
  %ylabel('pourcentage de population')
  %legend('S','I','R','%cumulé')

  



