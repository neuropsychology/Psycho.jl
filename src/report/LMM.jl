using MixedModels, GLM, DataFrames


data = simulate_data_correlation([[0.3, -0.1], [0.1, -0.4], [0.5, -0.25]])
model = fit(LinearMixedModel, @formula(y ~ Var1 * Var2 + (1|Group)), data)
confint(model)
boot = bootstrap(1000, model)

a = describe(model)


fieldnames(typeof(model.L.data))
fieldnames(typeof(model))


model.formula
model.formula.ex_orig
model.formula.ex
model.formula.lhs
model.formula.rhs

model.trms
model.trms[1]
model.trms[1].refs
model.trms[1].levels

model.trms[2]
model.trms[3]

model.sqrtwts


model.A
model.A.blocks
model.A.block_sizes

model.L
model.L.data.blocks
model.L.data.block_sizes


model.optsum
model.optsum.initial
model.optsum.optimizer
model.optsum.final

using InteractiveUtils
methodswith(typeof(model))

vcov(model)


C = model.trms[3]
ModelMatrix(model)
methods(typeof(model.formula))
varinfo(MixedModels)


model.formula
function model_description(model::MixedModels.LinearMixedModel)

    modelname = "linear mixed model"
    outcome = model.mf.terms.eterms[1]
    predictors = model.mf.terms.eterms[2:end]
    formula = model.formula

    output = Dict(
        "Model" => modelname,
        "Outcome" => outcome,
        "Predictors" => predictors,
        "Formula" => formula,
        "text_description" => "We fitted a linear regression to predict $outcome with $(join(predictors, ", ", " and ")) ($formula)."
        )
    return Report(text=output["text_description"], values=output)
end
