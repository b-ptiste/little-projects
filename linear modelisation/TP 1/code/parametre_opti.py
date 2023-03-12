# l'objectif ici est de voir quel est le paramètre w optimal+
# en effet la méthode de relaxation fait intervenir w. Il faut voir la valeurs pour laquelle le rayon spectral est moindre.



import numpy as np
import matplotlib.pyplot as plt
# on importe le fichier précédent, piur utiliser les fonctions qui y sont définis
from methode_numerique import *





def ray_spec(w,n):
    # on construit la matrice A 
    A=constructA(n)
    In=np.eye(n)
    D=np.diag(np.diag(A))
    E=np.tril(A,-1)
    mat_it=In-np.linalg.inv((1/w)*D+E).dot(A)
    eig=[np.abs(x) for x in np.linalg.eigvals(mat_it)]
    return (max(eig))


# fonction calculant le w pour lequel le rayon spectral est optimal théorique.
# grâce à la formule du poly.

# on peut appliquer ici cette formule, car ici la matrice A est tridiagonale.

def w_opt_th (n):
    A=constructA(n)
    D=np.diag(np.diag(A))
    # on construit la matrice d'iterration, de jacobi.
    mat_it=np.eye(n)-np.linalg.inv(D).dot(A)
    eig=[np.abs(x) for x in np.linalg.eigvals(mat_it)]
    r_sp=max(eig)
    return (2/(1+np.sqrt(1-r_sp**2)))
    



# programme principale.
if __name__ == "__main__":
    # varification, de la méthode calculant le rayon spectral.
    print(ray_spec(1,3))
    n=10
    w=np.linspace(0.000001,1.99999999,num=10000)
    r_sp=[]

    for i in range(len(w)) :
        r_sp.append(ray_spec(w[i],n))


    # gestion du graphique : 
    # il faut continuer la mise en forme des graphiques, la on a juste des méthodes, qui fonctionne
    # il faut mieux présenter les résultats.


    fig = plt.figure(1)
    ax=plt.axes()
    plt.plot(w,r_sp,label='p(w)')
    #plt.plot(w,np.abs(1-w),label='|1-w|')
    plt.title("Recherche du rayon spectral minimal")
    plt.axis([0,2,0,1.2])
    ax=ax.set(xlabel='w',ylabel='rayon_spectral')
    plt.legend(loc='upper left')
    plt.show()

    # avec la formule théorique, on retrouve bien 1.74... 
    # c'est rassurant.
    print(w_opt_th(n))


    