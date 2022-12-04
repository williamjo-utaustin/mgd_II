import numpy as np
import matplotlib.pyplot as plt

data_qx = np.genfromtxt("problem_c_Q_x.dat", delimiter = ",")
data_esbgk_qx = np.genfromtxt("problem_g_esbgk_Q_x.dat", delimiter = ",")



for i in range(2,12):
    time = (i-1) * 5
    plt.plot(data_qx[1:,0], data_qx[1:,i] , label = r'$\hat{t} = $'+str(time), linewidth = 2)
plt.xlim(0,75)
plt.legend(fontsize = 10)
plt.grid()
plt.xlabel(r'$\hat{x}$', fontsize = 14)
plt.ylabel(r'$\hat{q_x}$', fontsize = 14)
plt.xticks(fontsize = 14)
plt.yticks(fontsize = 14)
plt.tight_layout()
plt.savefig("problem_speed_BGK.png")
plt.show()

for i in range(2,12):
    time = (i-1) * 5
    plt.plot(data_esbgk_qx[1:,0], data_esbgk_qx[1:,i] , label = r'$\hat{t} = $'+str(time), linewidth = 2)
plt.xlim(0,75)
plt.legend(fontsize = 10)
plt.grid()
plt.xlabel(r'$\hat{x}$', fontsize = 14)
plt.ylabel(r'$\hat{q_x}$', fontsize = 14)
plt.xticks(fontsize = 14)
plt.yticks(fontsize = 14)
plt.tight_layout()
plt.savefig("problem_speed_ESBGK.png")
plt.show()

x_start_bgk = 0
t_start_bgk = 0

x_start_esbgk = 0
t_start_esbgk = 0

avg_speed_data_bgk = np.zeros([11,2])
avg_speed_data_esbgk = np.zeros([11,2])
for i in range(2,12):
    time = (i-1) * 5
    index= i - 1

    max_index_bgk = np.argmax(data_qx[1:,i])
    max_index_esbgk = np.argmax(data_esbgk_qx[1:,i])
    
    x_diff_bgk = data_qx[max_index_bgk,0] - x_start_bgk
    t_diff_bgk = time - t_start_bgk
    
    x_diff_esbgk = data_esbgk_qx[max_index_esbgk,0] - x_start_esbgk
    t_diff_esbgk = time - t_start_esbgk
    

    avg_speed_bgk = x_diff_bgk/(t_diff_bgk)
    avg_speed_data_bgk[index,0] = time
    avg_speed_data_bgk[index,1] = avg_speed_bgk
    print(time, avg_speed_bgk)
    
    avg_speed_esbgk = x_diff_esbgk/(t_diff_esbgk)
    avg_speed_data_esbgk[index,0] = time
    avg_speed_data_esbgk[index,1] = avg_speed_esbgk
    print(time, avg_speed_esbgk)

    x_start_bgk = data_qx[max_index_bgk,0]
    t_start_bgk = time
    
    x_start_esbgk = data_esbgk_qx[max_index_esbgk,0]
    t_start_esbgk = time

print("BGK Avg:", np.average(avg_speed_data_bgk[1:,1]))
print("ES-BGK Avg:", np.average(avg_speed_data_esbgk[1:,1]))

plt.plot(avg_speed_data_bgk[:,0], avg_speed_data_bgk[:,1], linewidth = 2, label="BGK")
plt.plot(avg_speed_data_esbgk[:,0], avg_speed_data_esbgk[:,1], linewidth = 2, label = "ES-BGK")
plt.xlim(0,50)
plt.ylim(0,1.5)
plt.grid()
plt.legend(fontsize = 10)
plt.xlabel(r'$\hat{t}$', fontsize = 14)
plt.ylabel(r'$\hat{u_{s}}$', fontsize = 14)
plt.xticks(fontsize = 14)
plt.yticks(fontsize = 14)
plt.tight_layout()
plt.savefig("problem_speed_BGK_2.png")
plt.show()