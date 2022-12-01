import numpy as np
import matplotlib.pyplot as plt

data_p = np.genfromtxt("problem_d_P.dat", delimiter = ",")
data_tauxx = np.genfromtxt("problem_d_Tau_xx.dat", delimiter = ",")

plt.rcParams['figure.figsize'] = (6, 6)

plt.plot(data_p[:,0], data_p[:,9], linewidth = 2)
plt.xlim(0,75)
plt.grid()
plt.xlabel(r'$\hat{x}$', fontsize = 14)
plt.ylabel(r'$\hat{p}$', fontsize = 14)
plt.xticks(fontsize = 14)
plt.yticks(fontsize = 14)
plt.tight_layout()
plt.savefig("problem_d_p.png")
plt.show()

plt.plot(data_tauxx[:,0], data_tauxx[:,9], linewidth = 2)
plt.xlim(0,75)
plt.grid()
plt.xlabel(r'$\hat{x}$', fontsize = 14)
plt.ylabel(r'$\hat{\tau_{xx}}$', fontsize = 14)
plt.xticks(fontsize = 14)
plt.yticks(fontsize = 14)
plt.tight_layout()
plt.savefig("problem_d_tau_xx.png")
plt.show()
