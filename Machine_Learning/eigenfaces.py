# Author Andrea Sessa
# Plotting the first 10 eigenvectors extracted by Randomized PCA

import logging
from time import time

from numpy.random import RandomState
import matplotlib.pyplot as plt

from sklearn.datasets import fetch_olivetti_faces
from sklearn.cluster import MiniBatchKMeans
from sklearn import decomposition

#Display the log to the stdout
logging.basicConfig(level=logging.INFO, format='%(asctime)s %(levelname)s %(message)s')
rows = 2
cols = 5
n_components = rows*cols
image_shape = (64, 64)
rng = RandomState(0)

# Load the dataset from http://cs.nyu.edu/~roweis/data/olivettifaces.mat
dataset = fetch_olivetti_faces(shuffle=True, random_state=rng)
faces = dataset.data

n_samples, n_features = faces.shape

#Subtract the mean to perform the PCA analysis
faces_centered = faces - faces.mean(axis=0)

# local centering
faces_centered -= faces_centered.mean(axis=1).reshape(n_samples, -1)

print("Dataset consists of %d faces" % n_samples)

#Utility function to plot the Eigenfaces
def plot_gallery(title, images, n_col=cols, n_row=rows):
    plt.figure(figsize=(2. * n_col, 2.26 * n_row))
    plt.suptitle(title, size=16)
    for i, comp in enumerate(images):
        plt.subplot(n_row, n_col, i + 1)
        vmax = max(comp.max(), -comp.min())
        plt.imshow(comp.reshape(image_shape), cmap=plt.cm.gray,
                   interpolation='nearest',
                   vmin=-vmax, vmax=vmax)
        plt.xticks(())
        plt.yticks(())
    plt.subplots_adjust(0.01, 0.05, 0.99, 0.93, 0.04, 0.)

rand_pca = decomposition.RandomizedPCA(n_components=n_components, whiten=True)

# Plot a sample of the input data
plot_gallery("First centered Olivetti faces", faces_centered[:n_components])

#Perform the randomized PCA
print("Extracting the first %d %s dimensions..." % (n_components, "RandomizedPCA"))
t0 = time()
data = faces_centered
rand_pca.fit(data)
train_time = (time() - t0)
print("Done in %0.3fs" % train_time)

components_ = rand_pca.components_
plot_gallery('%s - Train time %.1fs' % ("RandomizedPCA", train_time), components_[:n_components])
plt.show()
