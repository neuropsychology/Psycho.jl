using MixedModels, GLM, DataFrames


data = simulate_data_correlation([[0.3, -0.1], [0.1, -0.4], [0.5, -0.25]])
model = fit(LinearMixedModel, @formula(y ~ Var1 * Var2 + (1|Group)), data)
