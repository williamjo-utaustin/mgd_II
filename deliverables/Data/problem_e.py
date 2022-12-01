import numpy as np
import matplotlib.pyplot as plt

data_hs_nd = np.genfromtxt("problem_e_hs_nd.dat", delimiter = ",")
data_rg_nd = np.genfromtxt("problem_e_reg_nd.dat", delimiter = ",")

data_hs_T = np.genfromtxt("problem_e_hs_T.dat", delimiter = ",")
data_rg_T = np.genfromtxt("problem_e_reg_T.dat", delimiter = ",")

plt.rcParams['figure.figsize'] = (6, 6)

plt.plot(data_hs_nd[:,0], data_hs_nd[:,7], label = "BGK-HS")
plt.plot(data_rg_nd[:,0], data_rg_nd[:,7], label = "BGK-PM")
plt.xlim(0,75)
plt.legend(fontsize = 14)
plt.grid()
plt.xlabel(r'$\hat{x}$', fontsize = 14)
plt.ylabel(r'$\hat{n}$', fontsize = 14)
plt.xticks(fontsize = 14)
plt.yticks(fontsize = 14)
plt.tight_layout()
plt.savefig("problem_e_n.png")
plt.show()

plt.plot(data_hs_T[:,0], data_hs_T[:,7], label = "BGK-HS")
plt.plot(data_rg_T[:,0], data_rg_T[:,7], label = "BGK-PM")
plt.xlim(0,75)
plt.legend(fontsize = 14)
plt.grid()
plt.xlabel(r'$\hat{x}$', fontsize = 14)
plt.ylabel(r'$\hat{T}$', fontsize = 14)
plt.xticks(fontsize = 14)
plt.yticks(fontsize = 14)
plt.tight_layout()
plt.savefig("problem_e_T.png")
plt.show()
