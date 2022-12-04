import numpy as np
import matplotlib.pyplot as plt

data_u = np.genfromtxt("problem_a_Uprof.dat", delimiter = ",")
data_nd = np.genfromtxt("problem_a_Dprof.dat", delimiter = ",")
data_T = np.genfromtxt("problem_a_Tprof.dat", delimiter = ",")
data_p = np.genfromtxt("problem_d_P.dat", delimiter = ",")

index = 95
print("x range:", data_nd[index,0])
print("nd average: ", np.average(data_nd[1:index,11]))

plt.plot(data_nd[:,0],data_nd[:,11], '--', linewidth = 2,label = r'$\hat{n}_{whole}$')
plt.plot(data_nd[1:index,0],data_nd[1:index,11], color = 'red', linewidth = 4, label = r'$\hat{n}_{avg}$')
plt.xlim(0,75)
plt.legend(fontsize = 14) 
plt.grid()
plt.xlabel(r'$\hat{x}$', fontsize = 14)
plt.ylabel(r'$\hat{n}$', fontsize = 14)
plt.xticks(fontsize = 14)
plt.yticks(fontsize = 14)
plt.tight_layout()
plt.savefig("problem_h_BGK_n.png")
plt.show()

index = 95
print("x range:", data_T[index,0])
print("T average: ", np.average(data_T[1:index,11]))

plt.plot(data_T[:,0],data_T[:,11], '--', linewidth = 2,label = r'$\hat{T}_{whole}$')
plt.plot(data_T[1:index,0],data_T[1:index,11], color = 'red', linewidth = 4, label = r'$\hat{T}_{avg}$')
plt.xlim(0,75)
plt.legend(fontsize = 14) 
plt.grid()
plt.xlabel(r'$\hat{x}$', fontsize = 14)
plt.ylabel(r'$\hat{T}$', fontsize = 14)
plt.xticks(fontsize = 14)
plt.yticks(fontsize = 14)
plt.tight_layout()
plt.savefig("problem_h_BGK_T.png")
plt.show()


index = 95
print("x range:", data_p[index,0])
print("P average: ", np.average(data_p[1:index,11]))

plt.plot(data_p[:,0],data_p[:,11], '--', linewidth = 2,label = r'$\hat{p}_{whole}$')
plt.plot(data_p[1:index,0],data_p[1:index,11], color = 'red', linewidth = 4, label = r'$\hat{p}_{avg}$')
plt.xlim(0,75)
plt.legend(fontsize = 14) 
plt.grid()
plt.xlabel(r'$\hat{x}$', fontsize = 14)
plt.ylabel(r'$\hat{p}$', fontsize = 14)
plt.xticks(fontsize = 14)
plt.yticks(fontsize = 14)
plt.tight_layout()
plt.savefig("problem_h_BGK_p.png")
plt.show()