# resources: https://stackoverflow.com/questions/48085182/cross-validation-in-keras
# https://keras.io/getting-started/sequential-model-guide/
# https://machinelearningmastery.com/evaluate-performance-deep-learning-models-keras/
# https://scikit-learn.org/stable/tutorial/statistical_inference/model_selection.html
# https://stackoverflow.com/questions/46308374/what-is-validation-data-used-for-in-a-keras-sequential-model/46308466
# https://datascience.stackexchange.com/questions/15135/train-test-validation-set-splitting-in-sklearn
# https://www.kaggle.com/nunorc/predicting-pulsar-stars-using-a-neural-network
# https://machinelearningmastery.com/grid-search-hyperparameters-deep-learning-models-python-keras/
# https://scikit-learn.org/stable/modules/generated/sklearn.model_selection.GridSearchCV.html#sklearn.model_selection.GridSearchCV.fit
# https://machinelearningmastery.com/regression-tutorial-keras-deep-learning-library-python/
#Tayler Singleton

from sklearn.preprocessing import StandardScaler
from sklearn.model_selection import train_test_split
from keras.wrappers.scikit_learn import KerasClassifier
from sklearn.model_selection import GridSearchCV
from sklearn.model_selection import KFold
from keras.models import Sequential
from keras.layers import Dense
import pandas as pd

dataset = pd.read_csv("pulsar_stars.csv")

X_data = dataset.iloc[:, 0:-1].values
Y_data = dataset.iloc[:, -1].values

scaler = StandardScaler()
X_data = scaler.fit_transform(X_data)

train_ratio = 0.70
validation_ratio = 0.15
test_ratio = 0.15
ratio_remaining = 1 - test_ratio
ratio_val_adjusted = validation_ratio/ratio_remaining

x_train, x_test, y_train, y_test = train_test_split(X_data, Y_data, test_size= 1-train_ratio)
x_test, x_val, y_test, y_val = train_test_split(x_test,y_test, test_size=test_ratio/(test_ratio+validation_ratio))

def baseline_model():
    model = Sequential()
    model.add(Dense(6, input_dim=8, activation='relu'))
    model.add(Dense(1, activation='sigmoid'))
    model.compile(loss='binary_crossentropy', optimizer='adam', metrics=['accuracy'])
    return model

batch_size = [300, 400, 500]
epochs = [30, 40, 50]
param_grid = dict(batch_size=batch_size, epochs=epochs)

kfold = KFold(n_splits=3)
estimator = KerasClassifier(build_fn=baseline_model, verbose = 0)
grid = GridSearchCV(estimator,param_grid = param_grid, cv=kfold)
grid.fit(x_train, y_train, validation_data=(x_test, y_test))

means = grid.cv_results_['mean_test_score']
stds = grid.cv_results_['std_test_score']
for mean, std, params in zip(means, stds, grid.cv_results_['params']):
    print("%0.3f%% (+/-%0.03f%%) for %r"% (mean*100.0, (std * 2)*100.0, params))

print("Validation Data Accuracy: %.3f%%" % (grid.best_estimator_.score(x_val,y_val) * 100))
