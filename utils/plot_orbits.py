# Script for visualizing simulation *.dat output files

import sys

import numpy as np
import matplotlib.pyplot as plt

if (len(sys.argv) != 2):
    print("Usage: {} <output-file-path>".format(sys.argv[0]))
    exit()

dataFilePath = sys.argv[1]
data = np.loadtxt(dataFilePath)

objectIDList = np.unique(data[:,0]) 
objectCount = np.size(objectIDList)
labels = list(map(lambda id: 'Object #{:d}'.format(int(id)), objectIDList))
plotStyles1 =  ['ro','b-','g-','c-','m-','r--','b--','g--','c--']
plotStyles2 =  ['r-','b-','g-','c-','m-','r--','b--','g--','c--']

# Plot y(x,z) graph:
fig = plt.figure(1)
ax = plt.axes(projection='3d')

for i in range(0, objectCount):
    ax.scatter3D(data[i:-1:objectCount, 1], data[i:-1:objectCount, 2], data[i:-1:objectCount, 3], plotStyles1[i])

plt.xlabel('X,  [AU]')
plt.ylabel('Y,  [AU]')
plt.legend(labels)

plt.show()

# Plot x(t) graph:
fig = plt.figure(2)
ax = plt.axes()
for i in range(0, objectCount):
    plt.plot(data[i:-1:objectCount, 4], data[i:-1:objectCount, 1], plotStyles2[i])

plt.xlabel('Time, [s]')
plt.ylabel('X, [AU]')
plt.legend(labels)

plt.show()
