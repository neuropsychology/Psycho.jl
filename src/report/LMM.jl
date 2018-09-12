using MixedModels, GLM, DataFrames


# Simulate some data
data = simulate_data_correlation([[0.3], [0.1], [0.5]])
report(data)

typeof(data[:Group])
model = lmm(@formula(y ~ Var1 + (1|Group)), data)
model = fit(LinearMixedModel, @formula(y ~ Var1 + (1|Group)), data)




model = lmm(@formula(y ~ Var1 + (1|Group)), DataFrame(y=[1,2,3,4,5,6], Var1=[3,5,6,4,2,7], Group=["A", "A", "A", "B", "B", "B"]))
