import numpy as np
import matplotlib.pyplot as plt

data_hs_nd_2 = np.genfromtxt("problem_f_hs_Dprof2.dat", delimiter = ",")
data_rg_nd_2 = np.genfromtxt("problem_f_reg_Dprof2.dat", delimiter = ",")

data_hs_T_2 = np.genfromtxt("problem_f_hs_Tprof2.dat", delimiter = ",")
data_rg_T_2 = np.genfromtxt("problem_f_reg_Tprof2.dat", delimiter = ",")

data_hs_nd_1 = np.genfromtxt("problem_e_hs_nd.dat", delimiter = ",")
data_rg_nd_1 = np.genfromtxt("problem_e_reg_nd.dat", delimiter = ",")

data_hs_T_1 = np.genfromtxt("problem_e_hs_T.dat", delimiter = ",")
data_rg_T_1 = np.genfromtxt("problem_e_reg_T.dat", delimiter = ",")


plt.rcParams['figure.figsize'] = (6, 6)

plt.plot(data_hs_nd_1[:,0], data_hs_nd_1[:,7], label = "BGK-HS "+r'$\hat{u} = -1$', linewidth = 2)
plt.plot(data_rg_nd_1[:,0], data_rg_nd_1[:,7], label = "BGK-PM "+r'$\hat{u} = -1$', linewidth = 2)
plt.plot(data_hs_nd_2[:,0], data_hs_nd_2[:,7], label = "BGK-HS "+r'$\hat{u} = -2$', linewidth = 2)
plt.plot(data_rg_nd_2[:,0], data_rg_nd_2[:,7], label = "BGK-PM "+r'$\hat{u} = -2$', linewidth = 2)
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


plt.plot(data_hs_T_1[:,0], data_hs_T_1[:,7], label = "BGK-HS "+ r'$\hat{u} = -1$', linewidth = 2)
plt.plot(data_rg_T_1[:,0], data_rg_T_1[:,7], label = "BGK-PM "+ r'$\hat{u} = -1$', linewidth = 2)
plt.plot(data_hs_T_2[:,0], data_hs_T_2[:,7], label = "BGK-HS "+ r'$\hat{u} = -2$', linewidth = 2)
plt.plot(data_rg_T_2[:,0], data_rg_T_2[:,7], label = "BGK-PM "+ r'$\hat{u} = -2$', linewidth = 2)
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

#plt.plot(data_hs_U_2[:,0], data_hs_U_2[:,9], label = "BGK-HS", linewidth = 2)
#plt.plot(data_rg_U_2[:,0], data_rg_U_2[:,9], label = "BGK-PM", linewidth = 2)
#plt.xlim(0,75)
#plt.legend_2(fontsize = 14)
#plt.grid()
#plt.xlabel(r'$\hat{x}$', fontsize = 14)
#plt.ylabel(r'$\hat{U}$', fontsize = 14)
#plt.xticks(fontsize = 14)
#plt.yticks(fontsize = 14)
#plt.tight_layout()
#plt.savefig("problem_f_U.png")
#plt.show()
