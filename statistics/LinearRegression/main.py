from linear_regression import SimpleLinearRegression, MultipleLinearRegression

def main():
    choice = None
    while choice != 'q':
        choice = input("Single Linear Regression: 0;\nMultiple Linear Regression: 1;\n Input (int/q) > ")
        if choice == '0':
            slr = SimpleLinearRegression()
            slr.train()
            while choice != 'b':
                choice = input("Make prediction (float/b) > ")
                if choice.isdigit():
                    print(slr.predict(float(choice)))
            choice = input("Generate graph? (y/n) > ")
            if choice == 'y':
                slr.graph()

        elif choice == '1':
            mlr = MultipleLinearRegression()
            mlr.train(['sq_ft','bedrooms','age'], ['price'])
            while values != 'b':
                values = input("Enter (parameters seperated by space/b) > ")
                values = values.split()
                for idx,value in enumerate(values):
                    if value.isdigit():
                        values[idx] = float(value)
                    else:
                        print("Error, invalid values.")
                        exit()
                
                print(mlr.predict(values))

main()