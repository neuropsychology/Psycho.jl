import GLM

model = GLM.lm(GLM.@formula(y ~ Var1), simulate_data_correlation(0.2))

results = report(model)

@test length(results.values) == 28
@test length(table(results)) == 8
