library(ggplot2)

#Schéma d'Euler pour le vecteur 2D X_t
Euler_Scheme_3 <- function(t,h){
  #Matrice drift
  b = matrix(c(-0.5,-1,1,-0.5),byrow = T,ncol = 2)
  N = floor(t/h)
  #On définit une matrice (2,N) avec le X_0 tiré
  X_k = matrix(rnorm(2),nrow = 2)
  for(k in 1:N){
    tirage = X_k[,k] + b%*%X_k[,k]*h + rnorm(2,mean = 0,sd = sqrt(h))
    X_k = cbind(X_k,tirage)
  }
  return(X_k)
}

t = 10
#On trace 4 trajectoires
h = 2^(-3)
repli_1 <- replicate(2,Euler_Scheme_3(t,h))
plot(repli_1[1,,1],repli_1[2,,1],col = 'lightgreen',lty = 'dashed',lwd = 1.4,type = 'l',xlab = 'X_1',ylab = 'X_2',main = "Trajectoires",xlim = c(-2.3,2.3),ylim = c(-2.3,2.3))
points(repli_1[1,,2],repli_1[2,,2],col = 'lightblue',lwd = 0.9,type = 'l')

points(repli_1[1,1,1],repli_1[2,1,1],lwd = 3,col = 'green')
points(repli_1[1,length(repli_1[1,,1]),1],repli_1[2,length(repli_1[1,,1]),1],lwd = 3,col = 'green')
points(repli_1[1,1,2],repli_1[2,1,2],lwd = 3,col = 'blue')
points(repli_1[1,length(repli_1[1,,1]),2],repli_1[2,length(repli_1[1,,1]),2],lwd = 3,col = 'blue')
legend("topright",legend = c('1ère trajectoire','2nde trajectoire'),pch = 1,col = c('lightgreen','lightblue'))

h = 2^(-5)
repli_2 <- replicate(2,Euler_Scheme_3(t,h))
plot(repli_2[1,,1],repli_2[2,,1],col = 'lightgreen',lty = 'dashed',lwd = 1.4,type = 'l',xlab = 'X_1',ylab = 'X_2',main = "Trajectoires",xlim = c(-2.3,2.3),ylim = c(-2.3,2.3))
points(repli_2[1,,2],repli_2[2,,2],col = 'lightblue',lwd = 0.9,type = 'l')

points(repli_2[1,1,1],repli_2[2,1,1],lwd = 3,col = 'green')
points(repli_2[1,length(repli_2[1,,1]),1],repli_2[2,length(repli_2[1,,1]),1],lwd = 3,col = 'green')
points(repli_2[1,1,2],repli_2[2,1,2],lwd = 3,col = 'blue')
points(repli_2[1,length(repli_2[1,,1]),2],repli_2[2,length(repli_2[1,,1]),2],lwd = 3,col = 'blue')
legend("topright",legend = c('1ère trajectoire','2nde trajectoire'),pch = 1,col = c('lightgreen','lightblue'))


#Norme 2 à chaque pas de temps de discrétisation
norme2_tp3 <- function (X_k){
  N = length(X_k[1,])
  norme_2 = c()
  for(k in 1:N){
    norme_2 = c(norme_2,sum(X_k[,k]^2))
  }
  return(norme_2)
}

#Tracé des normes 2 pour ces 4 trajectoires
h = 2^(-3)
norme_2_1 = norme2_tp3(repli_1[,,1])
norme_2_2 = norme2_tp3(repli_1[,,2])
time = seq(0,t,h)
plot(time,norme_2_1,main = "Norme 2 de X_t",xlab = 't',ylab = 'Norme 2',type=  'l',col = 'lightgreen')
points(time,norme_2_2,type = 'l',col = 'lightblue')
legend("topleft",legend = c("Trajectoire 1","Trajectoire 2"),col = c("lightgreen","lightblue"),pch = 1)

h = 2^(-5)
norme_2_1 = norme2_tp3(repli_2[,,1])
norme_2_2 = norme2_tp3(repli_2[,,2])
time = seq(0,t,h)
plot(time,norme_2_1,main = "Norme 2 de X_t",xlab = 't',ylab = 'Norme 2',type=  'l',col = 'lightgreen')
points(time,norme_2_2,type = 'l',col = 'lightblue')
legend("topleft",legend = c("Trajectoire 1","Trajectoire 2"),col = c("lightgreen","lightblue"),pch = 1)


#Moyenne empirique pour approximer l'espérance de X^2
empirical_mean <- function(sample,M){
  #Matrice qui contient les normes 2 moyennées pour chaque pas de temps
  norme_2 = matrix(data  = NA,nrow= M,ncol = length(sample[1,,1]))
  for(i in 1:M){
    norme_2[i,] = norme2_tp3(sample[,,i])
  }
  return(apply(norme_2,2,FUN = 'mean'))
}

#Tracé de la norme 2 pour plusieurs h et plusieurs M
plot_diff_M_h <- function(t,h_vect,M_vect,couleur,type_l){
  cpt = 0
  cpt_l = 0
  p <- ggplot()
  for(h in h_vect){
    cpt_l = cpt_l + 1
    time = seq(0,t,h)
    for(M in M_vect){
      cpt = cpt+1
      sample <- replicate(M,Euler_Scheme_3(t,h))
      norme_2 <- empirical_mean(sample,M)
      df <- data.frame(Norme_2 = norme_2,Time  = time)
      title = paste("h = ",h,', M = ',M)
      p  = p +  geom_line(data = df,aes(x = Time,y = Norme_2),color = couleur[cpt],linetype =  type_l[cpt_l])
    }
  }
  p = p + geom_hline(yintercept = 2,col = 'yellow')
  print(p)
}

couleur = c("firebrick1","firebrick3","firebrick4","lightgreen","green","darkgreen","lightblue","blue","darkblue")
h_vect <- c(2^(-3),2^(-4),2^(-5))
M_vect = c(100,1000,10000)
type_l = c("dashed","dotted","solid")

plot_diff_M_h(t,h_vect,M_vect,couleur,type_l)

# Méthode de Romberg-Richardson
Romberg_Richardson <- function(t,h,M){
  sample_1 <- replicate(M,Euler_Scheme_3(t,h))
  sample_2 <- replicate(M,Euler_Scheme_3(t,h/2))
  
  
  empi_mean_h <- empirical_mean(sample_1,M)
  empi_mean_h_2 <- empirical_mean(sample_2,M)
  
  #Il y a 2 fois plus de point pour le empi_mean_h_2
  return(2*empi_mean_h_2[seq(1,length(empi_mean_h_2),2)] - empi_mean_h)
}

#Tracé de l'approximation R-R pour plusieurs M et plusieurs h
plot_diff_M_h_RR <- function(t,h_vect,M_vect,couleur,type_l){
  cpt = 0
  cpt_l = 0
  p <- ggplot()
  for(h in h_vect){
    cpt_l = cpt_l + 1
    time = seq(0,t,h)
    for(M in M_vect){
      cpt = cpt+1
      sample <- Romberg_Richardson(t,h,M)

      df <- data.frame(Norme_2 = sample,Time  = time)
      title = paste("h = ",h,', M = ',M)
      p  = p +  geom_line(data = df,aes(x = Time,y = Norme_2),color = couleur[cpt],linetype =  type_l[cpt_l])
    }
  }
  print(p)
}

couleur = c("firebrick1","firebrick3","firebrick4","lightgreen","green","darkgreen","lightblue","blue","darkblue")
h_vect <- c(2^(-3),2^(-4),2^(-5))
M_vect = c(100,1000,10000)
type_l = c("dashed","dotted","solid")

plot_diff_M_h_RR(t,h_vect,M_vect,couleur,type_l)

#Comparaison de la précision des deux méthodes
plot_comp_RR_Euler <- function(t,h,M){
  Euler <- empirical_mean(replicate(M,Euler_Scheme_3(t,h)),M)
  df1 <- data.frame(Norme_2 = Euler,Time = seq(0,t,h))
  
  RR <- Romberg_Richardson(t,h,M)
  df2 <- data.frame(Norme_2 = RR,Time = seq(0,t,h))
  
  p = ggplot()
  p  = p +  geom_line(data = df1,aes(x = Time,y = Norme_2,color = "Méthode Euler"))
  p  = p +  geom_line(data = df2,aes(x = Time,y = Norme_2,color = "Méthode RR"))
  p = p + scale_color_manual( values = c("red", "blue"))
  p = p + theme()
  print(p)
}

#Comparaison des deux méthodes d'approximations
plot_comp_RR_Euler(10,2^(-4),1000)
plot_comp_RR_Euler(10,2^(-4),100000)

plot_comp_RR_Euler(10,2^(-5),1000)
plot_comp_RR_Euler(10,2^(-5),100000)


