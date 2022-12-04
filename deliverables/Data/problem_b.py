#import numpy as np
#import matplotlib.pyplot as plt
#from mpl_toolkits import mplot3d
#
#data_40 = np.genfromtxt("problem_b_40_40.dat", delimiter = ",")
#data_45 = np.genfromtxt("problem_b_40_45.dat", delimiter = ",")
#data_50 = np.genfromtxt("problem_b_40_50.dat", delimiter = ",")
#
#my_cmap = plt.get_cmap('jet')
#
#fig = plt.figure()
#plt.rcParams['figure.figsize'] = (6, 6)
#ax = plt.axes(projection='3d')
#x = data_40[:,0]
#y = data_40[:,1]
#X_2D, Y_2D = np.meshgrid(x,y) 
#Z_2D=data_40[:,2]
#surf = ax.plot_trisurf(x, y, Z_2D, cmap = my_cmap,linewidth = 0.2, antialiased = True)
#plt.show()

import numpy as np
from mpl_toolkits.mplot3d import Axes3D
import matplotlib.pyplot as plt
from scipy.interpolate import griddata
import matplotlib.ticker as plticker


fig = plt.figure(figsize=(6,6), constrained_layout=True)
ax = plt.axes(projection='3d')
my_data = np.genfromtxt('problem_b_40_50.dat', delimiter = ',')
my_data[my_data==0] = np.nan 
my_data = my_data[~np.isnan(my_data).any(axis=1)]
X = my_data[:,0] * 0.7 
Y = my_data[:,1] * 0.7
Z = my_data[:,2]
xi = np.linspace(X.min(),X.max(),int(len(Z)/3))
yi = np.linspace(Y.min(),Y.max(),int(len(Z)/3))
zi = griddata((X, Y), Z, (xi[None,:], yi[:,None]), method='cubic')

xig, yig = np.meshgrid(xi, yi)

surf = ax.plot_surface(xig, yig, zi, cmap='jet')
cbar = fig.colorbar(surf, location = 'bottom', shrink=0.5)
cbar.ax.set_title(r'$\hat{\varphi}(\hat{\eta_1}, \hat{\eta_2}, 0)$')
ax.set_xlabel(r'$\hat{\eta_1}$', fontsize = 14)
ax.set_ylabel(r'$\hat{\eta_2}$', fontsize = 14)
ax.set_zlabel(r'$\hat{\varphi}$', fontsize = 14)
ax.tick_params(axis='x', labelsize=14)
ax.tick_params(axis='y', labelsize=14)
ax.tick_params(axis='z', labelsize=14)
loc = plticker.MultipleLocator(base=3.5) # this locator puts ticks at regular intervals
loc2 = plticker.MultipleLocator(base=0.02) # this locator puts ticks at regular intervals
ax.xaxis.set_major_locator(loc)
ax.yaxis.set_major_locator(loc)
ax.zaxis.set_major_locator(loc2)
ax.set_xlim3d(-7,7)
ax.set_ylim3d(-7,7)
ax.set_zlim3d(0,0.06)
plt.show()