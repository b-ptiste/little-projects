import numpy as np 
import matplotlib.pyplot as plt
import re 

from bs4 import BeautifulSoup
import requests 

url ='https://www.dvdfr.com/dvd/f300162-planete-des-singes-suprematie.html'
reponse = requests.get(url)
s = BeautifulSoup(reponse.text,"html.parser")
# On va chercher les classes div.
div1 = s.findAll("div",{"class" : "left twoColumns"}) 


chaine = ''
for d in div1 :
	chaine += str(d)

print(chaine.replace(" ",""))

