import GLM, DataFrames

data = simulate_data_correlation([[0.1], [0.3]])


# Vectors
@test isa(report([3,5,1]).text, String)
@test isa(report([3,5,1, missing]).text, String)
@test isa(report([3,5,1], median=true, dispersion=false, range=false).text, String)
@test isa(report(["a", "b", "c", "e", missing], n_strings=2).text, String)


# DataFrame
results = report(data)
@test isa(results.text, String)




# LM
model = GLM.lm(GLM.@formula(y ~ Var1 * Group), data)

results = report(model)
@test length(results.values) == 35
@test length(table(results)) == 8

results = report(model, CI=90, std_coefs=false, effect_size=nothing)
@test length(results.values) == 33

results = report(model, CI=90, std_coefs=false, effect_size="sawilowsky2009")
@test length(results.values) == 35



# GLM
data = simulate_data_logistic([[0.1], [0.3]])
model = GLM.glm(GLM.@formula(y ~ Var1 * Group), data, GLM.Binomial())

results = report(model)
@test length(results.values) == 34
@test length(table(results)) == 8

results = report(model, CI=90, std_coefs=false, effect_size=nothing)
@test length(results.values) == 32
