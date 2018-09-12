import GLM, DataFrames

data = simulate_data_correlation([[0.1], [0.3]])

# DataFrame
results = report(data)
@test isa(results.text, String)




# LM
model = GLM.lm(GLM.@formula(y ~ Var1 * Group), data)

results = report(model)

@test length(results.values) == 28
@test length(table(results)) == 8


# GLM
data = simulate_data_logistic([[0.1], [0.3]])
model = GLM.glm(GLM.@formula(y ~ Var1 * Group), data, GLM.Binomial())
results = report(model)

@test length(results.values) == 27
@test length(table(results)) == 8
