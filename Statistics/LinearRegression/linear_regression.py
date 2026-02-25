import matplotlib.pyplot as plt
from sklearn.linear_model import LinearRegression
from utils import load_csv

class SimpleLinearRegression:
    def __init__(self):
        self.df = load_csv()
        self.model = None

    def train(self) -> None:
        # Save data from csv object
        # Reshape converts array dimensions, taking parameters of rows and columns
        #   The value of -1 indicates reshape to automatically determine # of rows
        X = self.df[self.df.columns[0]].values.reshape(-1,1)
        y = self.df[self.df.columns[1]]

        # Create model object
        self.model = LinearRegression()

        # Train model on dataset
        self.model.fit(X,y)

        # Show parameters
        print("Model trained: ")
        print(f'Coefficients: {self.model.coef_}')
        print(f'Intercept: {self.model.intercept_}')

    def predict(self, x: float) -> float:
        return self.model.predict([[x]])

    def graph(self) -> None:
        # Save data from csv object
        X = self.df[self.df.columns[0]].values.reshape(-1,1)
        y = self.df[self.df.columns[1]]
        # Generate plot
        plt.scatter(X, y, color='blue', label='data points')
        # Best fit line
        plt.plot(X, self.model.predict(X), color='red', linewidth=2, label='best fit line')
        # Title and labels
        #plt.title('temp vs sales')
        plt.xlabel(self.df.columns[0])
        plt.ylabel(self.df.columns[1])
        plt.legend()

        # Save plot
        plt.savefig('regression_plot.png')
        print("Plot saved as regression_plot.png")

class MultipleLinearRegression:
    def __init__(self):
        self.df = load_csv()
        self.model = None

    # Features contains a list of column names that will be used for X
    # Target is the name of the column used for Y
    def train(self, features: list, target: list) -> None:
        X = self.df[features].values 

        # Set a single target column for Y
        y = self.df[target].values

        # Train model
        self.model = LinearRegression()
        self.model.fit(X,y)

        print("Model trained:")
        print(f"Coefficients: {self.model.coef_}")
        print(f"Intercept: {self.model.intercept_}")

    def predict(self, feature_values: list) -> float:
        # feature value array must be converted from 1D to 2D
        return self.model.predict([feature_values])
