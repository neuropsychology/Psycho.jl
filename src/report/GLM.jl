import Distributions, DataFrames, GLM, StatsModels
#

# data = simulate_data_logistic([0.1, 0.5], n=100)
# model = GLM.glm(GLM.@formula(y ~ Var1 + Var2), data, GLM.Binomial())
#
#
# print(typeof(model))
# model_description(model)
#




# function standardize(model::StatsModels.DataFrameRegressionModel{<:GLM.GeneralizedLinearModel})
# end


# GLM.GeneralizedLinearModel{GLM.GlmResp{Array{Float64,1},Distributions.Binomial{Float64},GLM.LogitLink}
function model_data(model::StatsModels.DataFrameRegressionModel{<:GLM.GeneralizedLinearModel})
    return model.mf.df
end





function model_description(model::StatsModels.DataFrameRegressionModel{<:GLM.GeneralizedLinearModel})

    modelname = "generalized linear model"
    outcome = model.mf.terms.eterms[1]
    predictors = model.mf.terms.eterms[2:end]
    formula = StatsModels.Formula(model.mf.terms)

    output = Dict(
        "Model" => modelname,
        "Outcome" => outcome,
        "Predictors" => predictors,
        "Formula" => formula,
        "text_description" => "We fitted a logistic regression to predict $outcome with $(join(predictors, ", ", " and ")) ($formula)."
        )
    return Report(text=output["text_description"], values=output)
end





function model_effects_existence(model::StatsModels.DataFrameRegressionModel{<:GLM.GeneralizedLinearModel})
    # Extract the p value
    # TODO: Damn it's complicated for now!

    coef_table = GLM.coeftable(model)
    p = [x.v for x in coef_table.cols[4]]

    output = Dict(
        "p" => p,
        "p_interpretation" => interpret_p.(p),
        "p_formatted" => format_p.(p))
    return output
end




function model_performance(model::StatsModels.DataFrameRegressionModel{<:GLM.GeneralizedLinearModel})

    R2 = r2_tjur(model)

    output = Dict(
        "R2" => R2,
        "text_performance" => "The model's explanatory power (Tjur's R²) is of $(round(R2, digits=2)).")

    return Report(text=output["text_performance"], values=output)
end







function model_initial_parameters(model::StatsModels.DataFrameRegressionModel{<:GLM.GeneralizedLinearModel})

    intercept = GLM.coef(model)[1]

    output = Dict(
        "Intercept" => intercept,
        "text_initial" => "The model's intercept is at $(round(intercept, digits=2)).")
    return Report(text=output["text_initial"], values=output)
end





function model_parameters(model::StatsModels.DataFrameRegressionModel{<:GLM.GeneralizedLinearModel}; CI=95)

    # Gather everything
    # ------------------

    parameters = GLM.coefnames(model)
    coefs = GLM.coef(model)
    std_errors = GLM.stderror(model)
    z = GLM.coeftable(model).cols[3]
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
                "z" => z,
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
        "z($(Int(parameters["DoF"][i+1]))) = $(round(parameters["z"][i+1], digits=2)), " *
        "$(parameters["CI_level"])% "*
        "[$(round(parameters["CI_lower"][i+1], digits=2)); " *
        "$(round(parameters["CI_higher"][i+1], digits=2))]" *
        ", $(parameters["p_formatted"][i+1]))"

        parameters["text_parameters"][i] = effect
    end

    return parameters
end







"""
    report(model::StatsModels.DataFrameRegressionModel{<:GLM.GeneralizedLinearModel}; CI::Number=95)

Describe a general linear model.

# Arguments
- `model`: A `GeneralizedLinearModel`.
- `CI::Number`: Confidence interval level.


# Examples
```julia
using GLM, DataFrames

model = glm(@formula(y ~ Var1), DataFrame(y=[0, 0, 1, 1], Var1=[1, 2, 2, 4]), GLM.Binomial())
report(model)

# output

We fitted a logistic regression to predict y with Var1 (Formula: y ~ 1 + Var1). The model's explanatory power (Tjur's R²) is of 0.5. The model's intercept is at -28.26. Within this model:
   - Var1 is not significant (coef = 14.13, z(2) = 0.02, 95% [-1375.39; 1403.64], p > .1)
```
"""
function report(model::StatsModels.DataFrameRegressionModel{<:GLM.GeneralizedLinearModel}; CI::Number=95)

    # Parameters
    parameters = model_parameters(model, CI=CI)

    # Text
    description = parameters["text_description"]
    performance = parameters["text_performance"]
    initial = parameters["text_initial"]

    text = "$description $performance $initial Within this model:"
    text = text * join("\n   - " .* parameters["text_parameters"])

    # Table
    table = hcat(parameters["Parameter"],
                parameters["Coef"],
                parameters["Std_error"],
                parameters["z"],
                parameters["DoF"],
                parameters["CI_lower"],
                parameters["CI_higher"],
                parameters["p"])

    table = DataFrames.DataFrame(table,
                [:Parameter,
                :Coef,
                :Std_Error,
                :z,
                :DoF,
                Symbol(parameters["CI_lower_formatted"]),
                Symbol(parameters["CI_higher_formatted"]),
                :p])
    return Report(text=text, values=parameters, table=table)
end
