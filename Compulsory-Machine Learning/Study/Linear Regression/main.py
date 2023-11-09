import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from linear_regression import LinearRegression

data = pd.read_excel("../data.xlsx")
train_data = data.sample(frac = 0.8)
test_data = data.drop(train_data.index)

input_param_name = 'features'
output_param_name = 'labels'

x_train = train_data[[input_param_name]].values
y_train = train_data[[output_param_name]].values

x_test = test_data[[input_param_name]].values
y_test = test_data[[output_param_name]].values

plt.scatter(x_train, y_train, label='Train Data', marker='x')
plt.scatter(x_test, y_test, label='Test Data')
plt.xlabel(input_param_name)
plt.ylabel(output_param_name)
plt.title("LAB")
plt.legend()
plt.show()



num_iteration = 500
learning_rate = 0.01
polynomials_degree = 4
sin_degree = 4


linear_regression = LinearRegression(x_train, y_train, polynomials_degree, sin_degree)
(theta, cost_history) = linear_regression.train(learning_rate, num_iteration)
print(cost_history[0])
print(cost_history[-1])
print(theta)

plt.plot(range(num_iteration), cost_history)
plt.xlabel("iter")
plt.ylabel("loss")
plt.title("Gradient Descent")
plt.show()


predictions_num = 100
x_prediction = np.linspace(x_train.min(), x_train.max(), predictions_num).reshape(predictions_num ,1)
y_prediction = linear_regression.predict(x_prediction)

plt.scatter(x_train, y_train, label='Train Data', marker='x')
plt.scatter(x_test, y_test, label='Test Data')
plt.plot(x_prediction, y_prediction,'r')
plt.xlabel(input_param_name)
plt.ylabel(output_param_name)
plt.title("Predict")
plt.legend()
plt.show()
