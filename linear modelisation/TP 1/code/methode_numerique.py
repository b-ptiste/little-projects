#    TP 1 MNL

# Objectif, implémenter des méthodes numériques, pour résoudre des systèmes du type
#  Ax=b

# remarque : la bibliothèque numpy offre les même possibilités que matlab, soit par np 
# soit par np.linalg pour les opérations, un peu plus matricielles.


##### Implémentation des méthodes.


import numpy as np
import matplotlib.pyplot as plt

################################################################
################################################################
def jacobi (A,b,x0,maxit):
    x=x0
    it=0
    # on crée la matrice D diagonale
    D=np.diag(np.diag(A))
    d=np.linalg.inv(D)
    while (it<maxit):
        xk=x-d.dot(A.dot(x))+d.dot(b)
        x=xk
        it+=1
    return (x)

################################################################
################################################################
def gauss_seidel (A,b,x0,maxit):
    x=x0
    it=0
    # on crée la matrice J de la méthode c'est la matrice D-E
    J=np.diag(np.diag(A))+np.tril(A,-1)
    # on inverse ici la matrice J
    j=np.linalg.inv(J)
    while (it<maxit):
        xk=x-j.dot(A.dot(x))+j.dot(b)
        x=xk
        it+=1
    return (x)

################################################################
################################################################
def relax (A,b,x0,w,maxit) :
    x=x0
    it=0
    J=(1/w)*np.diag(np.diag(A))+np.tril(A,-1)
    j=np.linalg.inv(J)
    while (it<maxit):
        xk=x-j.dot(A.dot(x))+j.dot(b)
        x=xk
        it+=1
    return (x)



################################################################
######### Construction des matrices liées au problème ##########
################################################################

def constructA(n):
    v1=np.repeat(2,n)
    v2=np.repeat(-1,n-1)
    A1=np.diag(v1)
    A2=np.diag(v2,1)
    A3=np.diag(v2,-1)
    return (A1+A2+A3)

################################################################
def constructB (n):
    b=np.repeat(0,n)
    b[0]=1
    b[-1]=1
    return(b)



################################################################
################# programme principale #########################
################################################################

if __name__ == "__main__":

    n=10
    # on prend un x0 au hasard
    x0=np.random.randn(n)
    A=constructA(n)
    b=constructB(n)
    w=3/2



    # varification des différentes méthodes numériques.
    
    print("-----Jacobi------")
    print(jacobi(A,b,x0,100))

    print("------GS---------")
    print(gauss_seidel(A,b,x0,100))


    print("------relaxation--------")
    print(relax(A,b,x0,w,100))

    print('\n')


    sol=np.repeat(1,n)
    print(A.dot(sol))
