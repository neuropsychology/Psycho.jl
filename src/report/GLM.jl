import DataFrames, GLM




function model_performance(model::StatsModels.DataFrameRegressionModel{<:GLM.LinearModel})

    R2 = r2(model)
    R2_Adj = adjr2(model)
    text = "The model's explanatory power (R²) is of $(round(R2, digits=2)) (Adj. R² = $(round(R2_Adj, digits=2)))."

    output = Dict(
        "R2" => R2,
        "R2_Adj" => R2_Adj,
        "text" => text)
    return output
end

function model_initial_parameters(model::StatsModels.DataFrameRegressionModel{<:GLM.LinearModel})
    intercept = coef(model)[1]
    text = "The model's intercept is at $(round(intercept, digits=2))."

    output = Dict(
        "Intercept" => intercept,
        "text" => text)
    return output
end


function model_effects_existence(model::StatsModels.DataFrameRegressionModel{<:GLM.LinearModel})
    # p value formula
    output = Distributions.ccdf.(
        Distributions.FDist(1, dof_residual(model)),
        abs2.(coef(model) ./ stderror(model))
    )
    return output
end


function model_table(model::StatsModels.DataFrameRegressionModel)

    names = coefnames(model)
    coefs = coef(model)
    std_errors = stderror(model)
    t_values = coefs ./ std_errors
    dof = repeat([dof_residual(model)], 2)
    ci = confint(model)
    pvalues = model_effects_existence(model)

    summary_table = hcat(names, coefs, std_errors, t_values, dof, ci, pvalues)
    summary_df = DataFrame(summary_table, [:Parameter, :Coef, :Std_Error, :t, :DoF, :CI_lower, :CI_higher, :p])
end

function model_effects(model::StatsModels.DataFrameRegressionModel{<:GLM.LinearModel})
    effects_table = model_table(model)

    output = Dict()
    for var in effects_table[:Parameter]
        output[var] = Dict()
        var_row = filter(row -> row[:Parameter] == var, effects_table)

        for i in names(var_row)
            output[var][string(i)] = var_row[i][1]
        end
        output[var]["text"] = "$(var_row[:Parameter][1]) is ... ()"
    end

    return output
end

function model_description(model::StatsModels.DataFrameRegressionModel{<:GLM.LinearModel})
    # TODO
end

function report(model::StatsModels.DataFrameRegressionModel{<:GLM.LinearModel})

    perf = model_performance(model)["text"]
    init = model_initial_parameters(model)["text"]

    println("$perf $init Within this model:")

    effects = model_effects(model)
    for var in coefnames(model)
        if var != "(Intercept)"
            println("   - " * effects[var]["text"])
        end
    end
end


function report_table()
end


# Test
include("../simulate/data_regression.jl")
# include("../interpret/interpret.jl.jl")
include("../interpret/pvalue.jl")


# GLM
df = simulate_data_regression(0.5, n=100)
model = GLM.lm(@formula(y ~ Var1), df)

model_initial_parameters(model)
model_performance(model)
model_table(model)
model_effects(model)
report(model)
