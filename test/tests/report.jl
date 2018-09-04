import GLM

data = simulate_data_correlation([[0.1], [0.3]])

# DataFrame
results = report(data)
@test isa(results.text, String)





model = GLM.lm(GLM.@formula(y ~ Var1 * Group), data)

results = report(model)

@test length(results.values) == 28
@test length(table(results)) == 8
