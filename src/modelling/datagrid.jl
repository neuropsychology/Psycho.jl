using GLM, DataFrames, Psycho


data = simulate_data_correlation([[0.2], [0.4]])


model = lm(@formula(y ~ Var1), DataFrame(y=[0, 0, 1, 1], Var1=[1, 2, 2, 4]), GLM.Binomial())
