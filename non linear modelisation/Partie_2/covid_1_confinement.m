clear all
close all
% scénario de confinement.
clear all
close all
T = 365*11; # étude 11 ans
T0 = 365*5/2; # 2.5 ans arrivé d'un variant
dt = 0.5; # on se place à l'echelle de la demi journée

I = [0:dt:T];
S0 =0.9;
I0 =0.1;
R0 = 0;
V0 = 0;
M0 = 0;
Y0 = [S0,I0,R0,V0,M0];
Y = [Y0];

% paramètres

# a : taux de vaccination
# b : taux de transmissibilité
# c : taux de retablissement
# d : retabli vers sain
# e : taux de mort du au virus
# g : efficacité du vaccination


for i = 1:(T/dt)
  yn = Y(i,:)';
  ####################################### 
  # modelisation de la premiere epidemie 
  ####################################### 
  if(i<=T0/dt)
    e = 0.0005;
    b =0.04;
    c = 0.02;
    d =0.1;
    ###### arrivé du vaccin
    if(i<=100/dt )
      a=0; # pas de vaccin
    elseif(i<=T0/dt) 
      a = 0.4; # vaccin 40% population
    endif
    ###### confinement
    
    ###### efficacité vaccin
    if(i<=100/dt )
      g = 0; # pas de vaccin
    elseif(i<=T0/dt) 
      g = 0.5; # vaccin ok à 50%
    endif  
  #######################################  
  # modelisation de la deuxieme epidemie 
  #######################################
  else
    c = 0.001;
    d =0.001;
    e = 0.0008;
    
    if(i == T0/dt)
      yn(1)=yn(1)+yn(3); # les r de la maladie 1 deviennent s pour la maladie 2
      yn(3)=0;
     endif
    ###### arrivé du vaccin
    if(i<=(T0+200)/dt )
      a=0; # pas de vaccin
    elseif(i<=(T0+450)/dt) 
      a = 0.8; # vaccin 80% population
    else 
      a = 0.9; # vaccin 90% population
    endif
    ###### confienement
    if(i<=(T0+600)/dt && i>=((T0+30)/dt))
      b = 0.01;
    else 
      b = 0.04;
    endif
    ###### efficacité vaccin
    if(i<=(T0+200)/dt )
      g = 1; # l'ancien vaccin ne sert a rien et pas de deuxieme vaccin
    elseif(i<=(T0+450)/dt) 
      g = 0.5; # vaccin ok à 50%
    else(i<=(T0+2500)/dt) 
      e = 0.0001; # beacoup moins de mort
      g = 0.0001; # vaccin efficace
    endif
    
  endif

  yn = yn+dt*f5(a,b,c,d,e,g,yn) ; 
  Y = [Y;yn'] ;
endfor
%

figure(1)
hold on

plot(I,Y(:,1),'k')
plot(I,Y(:,2),'r')
plot(I,Y(:,3),'b')
plot(I,Y(:,4),'g')
plot(I,Y(:,5),'m')
plot(I,Y(:,1)+Y(:,2)+Y(:,3)+Y(:,4)+Y(:,5))


seq = [0:0.01:1];
plot(T0,seq)
# premier virus
plot(100,seq,'g')

# deuxieme virus

plot(T0+200,seq,'g')
plot(T0+450,seq,'g') # vaccin moins efficace
plot(T0+600,seq,'b') #debut confinement
plot(T0+30,seq,'b') # fin confinement

legend('S','I','R','V','M')


title('Covid 1')
xlabel('11 ans en jour')
ylabel('evolution des populations en %')