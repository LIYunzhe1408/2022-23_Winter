import numpy as np
from utils.features.prepare_for_training import prepare_for_training

class LinearRegression:
    """
    1. 对数据预处理；
    2. 得到所有特征的个数
    3. 初始化参数矩阵
    """

    def __init__(self, data, labels, polynomial_degree=0, sinusoid_degree=0, normalize_data=True):
        (data_processed,
         features_mean,
         features_deviation
         ) = prepare_for_training(data, polynomial_degree, sinusoid_degree, normalize_data=True)

        self.data = data_processed
        self.labels = labels
        self.features_mean = features_mean
        self.features_deviation = features_deviation
        self.polynomial_degree = polynomial_degree
        self.sinusoid_degree = sinusoid_degree
        self.normalize_data = normalize_data

        number_features = self.data.shape[1]  # 数据的列，作为features的个数
        self.theta = np.zeros((number_features, 1))  # 初始化theta矩阵

    def train(self, learning_rate, num_iterations=500):
        """
        训练模块，执行梯度下降
        """
        cost_history = self.gradient_descent(learning_rate, num_iterations)
        return self.theta, cost_history

    def gradient_descent(self, learning_rate, num_iterations):
        """
        实际迭代模块
        """
        cost_history = []
        for _ in range(num_iterations):
            self.gradient_step(learning_rate)
            cost_history.append(self.cost_function(self.data, self.labels))
        return cost_history

    def gradient_step(self, learning_rate):
        """
        梯度下降参数更新计算方法， 是矩阵运算
        """
        num_samples = self.data.shape[0]
        prediction = LinearRegression.validate(self.data, self.theta)
        # 得到残差
        delta = prediction - self.labels
        # 更新参数
        theta = self.theta
        theta = theta - learning_rate * (1 / num_samples) * (np.dot(delta.T, self.data)).T  # 这里的转置可能有问题
        self.theta = theta

    def cost_function(self, data, labels):
        """
        损失计算方法
        """
        num_samples = data.shape[0]
        delta = LinearRegression.validate(self.data, self.theta) - labels
        cost = (1 / 2) * np.dot(delta.T, delta) / num_samples
        return cost[0][0]

    @staticmethod
    def validate(data, theta):
        predictions = np.dot(data, theta)
        return predictions

    def get_cost(self, data, labels):
        data_processed = prepare_for_training(data,
                                              self.polynomial_degree,
                                              self.sinusoid_degree,
                                              self.normalize_data)[0]

        return self.cost_function(data_processed, labels)

    def predict(self, data):
        """
        用训练好的模型预测结果
        """
        data_processed = prepare_for_training(data,
                                              self.polynomial_degree,
                                              self.sinusoid_degree,
                                              self.normalize_data)[0]
        predictions = LinearRegression.validate(data_processed, self.theta)
        return predictions
