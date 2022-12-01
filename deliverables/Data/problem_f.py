import numpy as np
import matplotlib.pyplot as plt

data_hs_nd = np.genfromtxt("problem_f_hs_Dprof2.dat", delimiter = ",")
data_rg_nd = np.genfromtxt("problem_f_reg_Dprof2.dat", delimiter = ",")

data_hs_T = np.genfromtxt("problem_f_hs_Tprof2.dat", delimiter = ",")
data_rg_T = np.genfromtxt("problem_f_reg_Tprof2.dat", delimiter = ",")

data_hs_U = np.genfromtxt("problem_f_hs_Uprof2.dat", delimiter = ",")
data_rg_U = np.genfromtxt("problem_f_reg_Uprof2.dat", delimiter = ",")

plt.rcParams['figure.figsize'] = (6, 6)

plt.plot(data_hs_nd[:,0], data_hs_nd[:,9], label = "BGK-HS", linewidth = 2)
plt.plot(data_rg_nd[:,0], data_rg_nd[:,9], label = "BGK-PM", linewidth = 2)
plt.xlim(0,75)
plt.legend(fontsize = 14)
plt.grid()
plt.xlabel(r'$\hat{x}$', fontsize = 14)
plt.ylabel(r'$\hat{n}$', fontsize = 14)
plt.xticks(fontsize = 14)
plt.yticks(fontsize = 14)
plt.tight_layout()
plt.savefig("problem_f_n.png")
plt.show()


plt.plot(data_hs_T[:,0], data_hs_T[:,9], label = "BGK-HS", linewidth = 2)
plt.plot(data_rg_T[:,0], data_rg_T[:,9], label = "BGK-PM", linewidth = 2)
plt.xlim(0,75)
plt.legend(fontsize = 14)
plt.grid()
plt.xlabel(r'$\hat{x}$', fontsize = 14)
plt.ylabel(r'$\hat{T}$', fontsize = 14)
plt.xticks(fontsize = 14)
plt.yticks(fontsize = 14)
plt.tight_layout()
plt.savefig("problem_f_T.png")
plt.show()

plt.plot(data_hs_U[:,0], data_hs_U[:,9], label = "BGK-HS", linewidth = 2)
plt.plot(data_rg_U[:,0], data_rg_U[:,9], label = "BGK-PM", linewidth = 2)
plt.xlim(0,75)
plt.legend(fontsize = 14)
plt.grid()
plt.xlabel(r'$\hat{x}$', fontsize = 14)
plt.ylabel(r'$\hat{U}$', fontsize = 14)
plt.xticks(fontsize = 14)
plt.yticks(fontsize = 14)
plt.tight_layout()
plt.savefig("problem_f_U.png")
plt.show()
