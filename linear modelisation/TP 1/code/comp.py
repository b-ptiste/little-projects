from methode_numerique import *
import numpy as np
import matplotlib.pyplot as plt
##################################################################
################### Comparaison des iterations ################### 
##################################################################

######## Nombre d'iterrations Pour la méthode Jacobi #############
def it_jacobi (A,b,x0,eps):
    x=x0
    it=0
    err=1.0
    D=np.diag(np.diag(A))

    d=np.linalg.inv(D)
    sol_exact=np.linalg.inv(A).dot(b)
    while (err>=eps):
        x=x-d.dot(A.dot(x))+d.dot(b)
        err=np.linalg.norm(x-sol_exact)
        it+=1
    return (it)

def ray_spec_Jaco(A,n):
    inv_d=np.linalg.inv(np.diag(np.diag(A)))
    mat_it=np.eye(n)-inv_d.dot(A)
    eig=[np.abs(x) for x in np.linalg.eigvals(mat_it)]
    return (max(eig))


######## Nombre d'iterrations Pour la méthode Gauss #############
def it_gs (A,b,x0,eps):
    x=x0
    it=0
    err=1.0 
    J=np.diag(np.diag(A))+np.tril(A,-1)
    j=np.linalg.inv(J)
    sol_exact=np.linalg.inv(A).dot(b)
    while (err>eps):
        x=x-j.dot(A.dot(x))+j.dot(b)
        err=np.linalg.norm(x-sol_exact)
        it+=1
    return (it)


def ray_spec_gs(A,n):
    inv_J=np.linalg.inv(np.diag(np.diag(A))+np.tril(A,-1))
    # matrice d'iterration.
    mat_it=np.eye(n)-inv_J.dot(A)
    eig=[np.abs(x) for x in np.linalg.eigvals(mat_it)]
    return (max(eig))


######## Nombre d'iterrations Pour la méthode Relax #############

# on calcule le w opt
def w_opt (A,n):
    return(2/(1+np.sqrt(1-ray_spec_Jaco(A,n)**2)))


def it_relax (A,b,x0,eps):
    n=A.shape[0]
    x=x0
    it=0
    err=1.0
    # on choisit le w optimal.
    w=w_opt(A,n)
    J=(1/w)*np.diag(np.diag(A))+np.tril(A,-1)
    j=np.linalg.inv(J)
    sol_exact=np.linalg.inv(A).dot(b)
    while (err>eps):
        x=x-j.dot(A.dot(x))+j.dot(b)
        err=np.linalg.norm(x-sol_exact)
        it+=1
    return (it)

def ray_spec_relax(A,n):
    w=w_opt(A,n)
    J=(1/w)*np.diag(np.diag(A))+np.tril(A,-1)
    j=np.linalg.inv(J)
    mat_it=np.eye(n)-j.dot(A)
    eig=[np.abs(x) for x in np.linalg.eigvals(mat_it)]
    return (max(eig))
    


# calculs du nombre d'iterration théorique : 

def it_th_J(A,b,x0,eps):
    n=A.shape[0]
    x1=jacobi(A,b,x0,1)
    rho_I=ray_spec_Jaco(A,n)
    num=np.log(eps)-np.log(np.linalg.norm(x1-x0))
    den=np.log(rho_I)
    return(1+num/den)

def it_th_GS(A,b,x0,eps):
    n=A.shape[0]
    x1=gauss_seidel(A,b,x0,1)
    rho_I=ray_spec_gs(A,n)
    num=np.log(eps)-np.log(np.linalg.norm(x1-x0))
    den=np.log(rho_I)
    return(1+num/den)

def it_th_Relax(A,b,x0,eps):
    n=A.shape[0]
    w=w_opt(A,n)
    x1=relax(A,b,x0,w,1)
    rho_I=ray_spec_relax(A,n)
    num=np.log(eps)-np.log(np.linalg.norm(x1-x0))
    den=np.log(rho_I)
    return(1+num/den)



def nb_iterrations(A,n,meth):
    meth(A,n)
    
        





if __name__ == "__main__":

    N=np.arange(5,50,1)

    IT_J=[]
    IT_J_th=[]
    IT_GS=[]
    IT_GS_th=[]
    IT_R=[]
    IT_R_th=[]

    rsp_J=[]
    rsp_GS=[]
    rsp_R=[]

    eps=pow(10,-12)

    for n in N :
        #init
        x0=np.random.randn(n)
        A=constructA(n)
        b=constructB(n)
        # iterations
        IT_J.append(it_jacobi(A,b,x0,eps))
        IT_J_th.append(it_th_J(A,b,x0,eps))
        IT_GS.append(it_gs(A,b,x0,eps))
        IT_GS_th.append(it_th_GS(A,b,x0,eps))
        IT_R.append(it_relax(A,b,x0,eps))
        IT_R_th.append(it_th_Relax(A,b,x0,eps))
        # rayon spectral.
        rsp_J.append(ray_spec_Jaco(A,n))
        rsp_GS.append(ray_spec_gs(A,n))
        rsp_R.append(ray_spec_relax(A,n))


    # gestion graphique.....
    fig=plt.figure(figsize=(10,10))
    fig.add_subplot(121)
    plt.style.use('seaborn-whitegrid')
    plt.plot(N,IT_J,label="méthode Jacobi",color='red')
    plt.plot(N,IT_J_th,color='black')
    plt.plot(N,IT_GS_th,color='black')
    plt.plot(N,IT_R_th,color='black')
    plt.plot(N,IT_GS,label="méthode Gauss",color='blue')
    plt.plot(N,IT_R,label="méthode relax",color='green')
    plt.legend(loc='upper left')
    ax=plt.gca()
    ax=ax.set(xlabel='Dimension n',ylabel='Nombre iterrations')
    plt.title("nombre d'iterrations en fonction de la taille n")

    fig.add_subplot(122)
    plt.style.use('seaborn-whitegrid')
    plt.plot(N,rsp_J,color='red',label="méthode Jacobi")
    plt.plot(N,rsp_GS,color='blue',label="méthode Gauss")
    plt.plot(N,rsp_R,color='green',label="méthode Relax")
    plt.legend(loc='lower right')
    plt.title("rayon spectral en fonction de la taille n")
    ax=plt.gca()
    ax.set(xlabel='Dimension n',ylabel='rayon spectral')
    plt.show()
