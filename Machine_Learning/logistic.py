#Author: Andrea Sessa
#Logistic Regression implementation

import numpy as np
import matplotlib.pyplot as plt
from sklearn import datasets

# import some data to play with
iris = datasets.load_iris()
X = iris.data[:, :2]  # we only take the first two features.
T = iris.target

i = 0
for t in T:
    if  t > 1:
        T[i] = 1
    i += 1

h = .01  # step size in the mesh
etaS = 0.9 #Learning rate
N = 150 #training set size

#We want to find minimum of the cross-entropy function
#using stocastic gradient descent

def sigmoid(x,w):
    c = np.cross(w,x)
    if c > -100:
        return 1 / (1 + np.exp(-c))
    else:
        return 0


def update(w,x,t,eta):
    y = sigmoid(x,w)
    h = y - t
    g = h*x
    return w - eta*g

def train():
    c = 0
    w = np.array([0,0])
    for n in range(10):
        c = 0
        for x in X:
            w = update(w,x,T[c],etaS / (1 + c / float(N)))
            c += 1
    return w

def predict(w,M):
    c = []
    for x in M:
        if sigmoid(x,w) > 0.5:
            c.append(1)
        else:
            c.append(0)
    return np.array(c)


if __name__ == "__main__":
    #Learn the model using logistic regression
    w = train()
    # Plot the decision boundary. For that, we will assign a color to each
    # point in the mesh [x_min, m_max]x[y_min, y_max].
    x_min, x_max = X[:, 0].min() - .5, X[:, 0].max() + .5
    y_min, y_max = X[:, 1].min() - .5, X[:, 1].max() + .5
    xx, yy = np.meshgrid(np.arange(x_min, x_max, h), np.arange(y_min, y_max, h))

    #Predict the output for the meshgrid
    Z = predict(w,np.c_[xx.ravel(), yy.ravel()])
    #Z = logreg.predict(np.c_[xx.ravel(), yy.ravel()])
    print(w)
    # Put the result into a color plot
    Z = Z.reshape(xx.shape)
    plt.figure(1, figsize=(4, 3))
    plt.pcolormesh(xx, yy, Z, cmap=plt.cm.Paired)

    # Plot also the training points
    plt.scatter(X[:, 0], X[:, 1], c=T, edgecolors='k', cmap=plt.cm.Paired)
    plt.xlabel('Sepal length')
    plt.ylabel('Sepal width')

    plt.xlim(xx.min(), xx.max())
    plt.ylim(yy.min(), yy.max())
    plt.xticks(())
    plt.yticks(())

    plt.show()
