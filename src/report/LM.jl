import Distributions, DataFrames, GLM, StatsModels









function standardize(model::StatsModels.DataFrameRegressionModel{<:GLM.LinearModel})
    std_data = standardize(model_data(model))
    std_model = lm(StatsModels.Formula(model.mf.terms), std_data)
    return std_model
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






function model_std_parameters(model::StatsModels.DataFrameRegressionModel{<:GLM.LinearModel}; CI=95)

    std_model = standardize(model)

    # Gather values
    coefs = GLM.coef(std_model)
    std_errors = GLM.stderror(std_model)
    ci = GLM.confint(std_model, CI/100)
    ci_lower = ci[:, 1]
    ci_higher = ci[:, 2]

    parameters = Dict{Any, Any}(
        "Std_Coef" => coefs,
        "Std_SE" => std_errors,
        "Std_CI" => ci,
        "Std_CI_lower" => ci_lower,
        "Std_CI_higher" => ci_higher)

    return parameters
end








function model_effect_size(model::StatsModels.DataFrameRegressionModel{<:GLM.LinearModel}, coefs::Vector{<:Number}; rules="cohen1988", add_std::Bool=true)

    effect_size = interpret_d.(coefs, rules=rules)

    output = Dict{Any, Any}("Effect_Size" => effect_size)

    # Effects
    # --------
    # Generate empty vector
    output["text_effect_size"] = string.(zeros(length(output["Effect_Size"])))
    for i in 1:length(output["text_effect_size"])
        effect = " and can be considered as $(output["Effect_Size"][i])"

        if add_std == true
            effect = effect * " (Std. Coef = $(round(coefs[i], digits=2)))."
        else
            effect = effect * "."
        end

        output["text_effect_size"][i] = effect
    end

    return output
end








function model_initial_parameters(model::StatsModels.DataFrameRegressionModel{<:GLM.LinearModel})

    intercept = GLM.coef(model)[1]

    output = Dict(
        "Intercept" => intercept,
        "text_initial" => "The model's intercept is at $(round(intercept, digits=2)).")
    return Report(text=output["text_initial"], values=output)
end






function model_parameters(model::StatsModels.DataFrameRegressionModel{<:GLM.LinearModel};
    CI::Number=95,
    std_coefs::Bool=true,
    effect_size="cohen1988")

    # Gather everything
    # ------------------

    parameters = GLM.coefnames(model)
    coefs = GLM.coef(model)
    std_errors = GLM.stderror(model)
    t = GLM.coeftable(model).cols[3]
    DoF = repeat([GLM.dof_residual(model)], length(parameters))
    ci = GLM.confint(model, CI/100)
    ci_bounds = [(100-CI)/2, 100-(100-CI)/2]
    ci_lower = ci[:, 1]
    ci_higher = ci[:, 2]
    LogLikelihood = GLM.loglikelihood(model)
    deviance = GLM.deviance(model)
    sigma = sqrt(deviance/GLM.dof_residual(model))

    parameters = Dict{Any, Any}(
                "Parameter" => parameters,
                "Coef" => coefs,
                "SE" => std_errors,
                "t" => t,
                "DoF" => DoF,
                "CI_level" => CI,
                "CI" => ci,
                "CI_bounds" => ci_bounds,
                "CI_lower" => ci_lower,
                "CI_higher" => ci_higher,
                "CI_lower_formatted" => "CI_$(ci_bounds[1])",
                "CI_higher_formatted" => "CI_$(ci_bounds[2])",
                "LogLikelihood" => LogLikelihood,
                "Deviance" => deviance)

    parameters = merge(parameters, model_description(model).values)
    parameters = merge(parameters, model_performance(model).values)
    parameters = merge(parameters, model_initial_parameters(model).values)
    parameters = merge(parameters, model_effects_existence(model))
    parameters = merge(parameters, model_std_parameters(model, CI=CI))

    if effect_size != nothing
        if std_coefs == true
            parameters = merge(parameters, model_effect_size(model, parameters["Std_Coef"], rules=effect_size, add_std=true))
        else
            parameters = merge(parameters, model_effect_size(model, coefs, rules=effect_size, add_std=false))
        end
    end



    # Effects
    # --------

    # Generate empty vector
    parameters["text_parameters"] = string.(zeros(length(parameters["Parameter"])))
    for (i, var) in enumerate(parameters["Parameter"])
        effect =
        "$var is $(parameters["p_interpretation"][i]) " *
        "(Coef = $(round(parameters["Coef"][i], digits=2)), " *
        "t($(Int(parameters["DoF"][i]))) = $(round(parameters["t"][i], digits=2)), " *
        "$(parameters["CI_level"])% CI "*
        "[$(round(parameters["CI_lower"][i], digits=2)); " *
        "$(round(parameters["CI_higher"][i], digits=2))]" *
        ", $(parameters["p_formatted"][i]))"
        if effect_size != nothing
            effect = effect * parameters["text_effect_size"][i]
        else
            effect = effect * "."
        end

        parameters["text_parameters"][i] = effect
    end

    return parameters
end







"""
    report(model::StatsModels.DataFrameRegressionModel{<:GLM.LinearModel};
        CI::Number=95,
        std_coefs::Bool=true,
        effect_size="cohen1988")

Describe a linear model.

# Arguments
- `model`: A `LinearModel`.
- `CI`: Confidence interval level.
- `std_coefs`: Interpret effect sizes of standardized, rather than raw, coefs.
- `effect_size`: Can be 'cohen1988', 'sawilowsky2009', or custom set of [Rules](@ref) (See [cohen_d](@ref)). Set to `nothing` to omit interpretation.

# Examples
```julia
using GLM, DataFrames

model = lm(@formula(y ~ Var1), DataFrame(y=[0, 1, 2, 3], Var1=[2, 3, 3.5, 4]))
report(model)
```
"""
function report(model::StatsModels.DataFrameRegressionModel{<:GLM.LinearModel};
    CI::Number=95,
    std_coefs::Bool=true,
    effect_size="cohen1988")

    # Parameters
    parameters = model_parameters(model,
                                CI=CI,
                                std_coefs=std_coefs,
                                effect_size=effect_size)

    # Text
    description = parameters["text_description"]
    performance = parameters["text_performance"]
    initial = parameters["text_initial"]

    text = "$description $performance $initial Within this model:"
    text = text * join("\n  - " .* parameters["text_parameters"][2:end])

    text = format_text(text)


    # Table
    table = hcat(parameters["Parameter"],
                parameters["Coef"],
                parameters["SE"],
                parameters["t"],
                parameters["DoF"],
                parameters["CI_lower"],
                parameters["CI_higher"],
                parameters["p"])

    table = DataFrames.DataFrame(table,
                [:Parameter,
                :Coef,
                :SE,
                :t,
                :DoF,
                Symbol(parameters["CI_lower_formatted"]),
                Symbol(parameters["CI_higher_formatted"]),
                :p])
    return Report(text=text, values=parameters, table=table)
end
