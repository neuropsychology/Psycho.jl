import DataFrames, GLM

df = simulate_data_correlation([[0.2, 0.5], [0.4]])

model = GLM.lm(GLM.@formula(y ~ Var1), df)
data = datagrid(model)

data[:y_pred] = GLM.predict(model, data)
GLM.predict(model, data, interval_type=:confint)


using Plots
plot(data[:Var1], data[:y_pred], ribbon=(0.5, 1), fillalpha=.5)
