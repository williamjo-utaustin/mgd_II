import numpy as np
import matplotlib.pyplot as plt

data_qx = np.genfromtxt("problem_c_Q_x.dat", delimiter = ",")
data_qy = np.genfromtxt("problem_c_Q_y.dat", delimiter = ",")
data_qz = np.genfromtxt("problem_c_Q_z.dat", delimiter = ",")

plt.rcParams['figure.figsize'] = (6, 6)

plt.plot(data_qx[:,0], data_qx[:,9], label = r'$\hat{q_x}$', linewidth = 2)
plt.plot(data_qy[:,0], data_qy[:,9], label = r'$\hat{q_y}$', linewidth = 2)
plt.plot(data_qz[:,0], data_qz[:,9], label = r'$\hat{q_z}$', linewidth = 2)

plt.xlim(0,75)
plt.legend(fontsize = 14)
plt.grid()
plt.xlabel(r'$\hat{x}$', fontsize = 14)
plt.ylabel(r'$\hat{q}$', fontsize = 14)
plt.xticks(fontsize = 14)
plt.yticks(fontsize = 14)
plt.tight_layout()
plt.savefig("problem_c.png")
plt.show()
