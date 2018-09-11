import Distributions, DataFrames, GLM, StatsModels







function standardize(model::StatsModels.DataFrameRegressionModel{<:GLM.LinearModel})
end





function model_data(model::StatsModels.DataFrameRegressionModel{<:GLM.LinearModel})
    return model.mf.df
end





function model_description(model::StatsModels.DataFrameRegressionModel{<:GLM.LinearModel})

    modelname = "linear model"
    outcome = model.mf.terms.eterms[1]
    predictors = model.mf.terms.eterms[2:end]
    formula = StatsModels.Formula(model.mf.terms)

    output = Dict(
        "Model" => modelname,
        "Outcome" => outcome,
        "Predictors" => predictors,
        "Formula" => formula,
        "text_description" => "We fitted a linear regression to predict $outcome with $(join(predictors, ", ", " and ")) ($formula)."
        )
    return Report(text=output["text_description"], values=output)
end








function model_effects_existence(model::StatsModels.DataFrameRegressionModel{<:GLM.LinearModel})
    # p value formula
    # TODO: Damn it's complicated for now!

    coef_table = GLM.coeftable(model)
    p = [x.v for x in coef_table.cols[4]]

    output = Dict(
        "p" => p,
        "p_interpretation" => interpret_p.(p),
        "p_formatted" => format_p.(p))
    return output
end






function model_performance(model::StatsModels.DataFrameRegressionModel{<:GLM.LinearModel})

    R2 = GLM.r2(model)
    R2_adj = GLM.adjr2(model)

    output = Dict(
        "R2" => R2,
        "R2_adj" => R2_adj,
        "text_performance" => "The model's explanatory power (R²) is of $(round(R2, digits=2)) (adj. R² = $(round(R2_adj, digits=2))).")

    return Report(text=output["text_performance"], values=output)
end







function model_initial_parameters(model::StatsModels.DataFrameRegressionModel{<:GLM.LinearModel})

    intercept = GLM.coef(model)[1]

    output = Dict(
        "Intercept" => intercept,
        "text_initial" => "The model's intercept is at $(round(intercept, digits=2)).")
    return Report(text=output["text_initial"], values=output)
end





function model_parameters(model::StatsModels.DataFrameRegressionModel{<:GLM.LinearModel}; CI=95)

    # Gather everything
    # ------------------

    parameters = GLM.coefnames(model)
    coefs = GLM.coef(model)
    std_errors = GLM.stderror(model)
    t = GLM.coeftable(model).cols[3]
    dof = repeat([GLM.dof_residual(model)], length(parameters))
    ci = GLM.confint(model, CI/100)
    ci_bounds = [(100-CI)/2, 100-(100-CI)/2]
    ci_lower = ci[:, 1]
    ci_higher = ci[:, 2]
    loglikelihood = GLM.loglikelihood(model)
    deviance = GLM.deviance(model)
    sigma = sqrt(deviance/GLM.dof_residual(model))

    parameters = Dict(
                "Parameter" => parameters,
                "Coef" => coefs,
                "Std_error" => std_errors,
                "t" => t,
                "DoF" => dof,
                "CI_level" => CI,
                "CI" => ci,
                "CI_bounds" => ci_bounds,
                "CI_lower" => ci_lower,
                "CI_higher" => ci_higher,
                "CI_lower_formatted" => "CI_$(ci_bounds[1])",
                "CI_higher_formatted" => "CI_$(ci_bounds[2])",
                "loglikelihood" => ci_higher,
                "deviance" => deviance)

    parameters = merge(parameters, model_description(model).values)
    parameters = merge(parameters, model_performance(model).values)
    parameters = merge(parameters, model_initial_parameters(model).values)
    parameters = merge(parameters, model_effects_existence(model))



    # Effects
    # --------

    # Generate empty vector
    parameters["text_parameters"] = string.(zeros(length(parameters["Parameter"])-1))
    for (i, var) in enumerate(filter(x -> x != "(Intercept)", parameters["Parameter"]))
        effect =
        "$var is $(parameters["p_interpretation"][i+1]) " *
        "(coef = $(round(parameters["Coef"][i+1], digits=2)), " *
        "t($(Int(parameters["DoF"][i+1]))) = $(round(parameters["t"][i+1], digits=2)), " *
        "$(parameters["CI_level"])% "*
        "[$(round(parameters["CI_lower"][i+1], digits=2)); " *
        "$(round(parameters["CI_higher"][i+1], digits=2))]" *
        ", $(parameters["p_formatted"][i+1]))"

        parameters["text_parameters"][i] = effect
    end

    return parameters
end







"""
    report(model::StatsModels.DataFrameRegressionModel{<:GLM.LinearModel}; CI::Number=95)

Describe a linear model.

# Arguments
- `model`: A `LinearModel`.
- `CI::Number`: Confidence interval level.


# Examples
```julia
using GLM, DataFrames

model = lm(@formula(y ~ Var1), DataFrame(y=[0, 1, 2, 3], Var1=[2, 3, 3.5, 4]))
report(model)

# output

We fitted a linear regression to predict y with Var1 (Formula: y ~ 1 + Var1). The model's explanatory power (R²)
is of 0.97 (adj. R² = 0.95). The model's intercept is at -3.14. Within this model:
  - Var1 is significant (coef = 1.49, t(2) = 7.51, 95% [0.63; 2.34], p < .05)
```
"""
function report(model::StatsModels.DataFrameRegressionModel{<:GLM.LinearModel}; CI::Number=95)

    # Parameters
    parameters = model_parameters(model, CI=CI)

    # Text
    description = parameters["text_description"]
    performance = parameters["text_performance"]
    initial = parameters["text_initial"]

    text = "$description $performance $initial Within this model:"
    text = text * join("\n  - " .* parameters["text_parameters"])

    text = format_text(text)


    # Table
    table = hcat(parameters["Parameter"],
                parameters["Coef"],
                parameters["Std_error"],
                parameters["t"],
                parameters["DoF"],
                parameters["CI_lower"],
                parameters["CI_higher"],
                parameters["p"])

    table = DataFrames.DataFrame(table,
                [:Parameter,
                :Coef,
                :Std_Error,
                :t,
                :DoF,
                Symbol(parameters["CI_lower_formatted"]),
                Symbol(parameters["CI_higher_formatted"]),
                :p])
    return Report(text=text, values=parameters, table=table)
end
