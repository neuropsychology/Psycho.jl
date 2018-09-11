import Statistics, StatsModels, GLM




"""
    r2_tjur(model::StatsModels.DataFrameRegressionModel{<:GLM.GeneralizedLinearModel})

Compute Tjur's (2009) D (R²).

The Coefficients of Determination (D), also referred to as Tjur's R² ([Tjur, 2009](https://amstat.tandfonline.com/doi/abs/10.1198/tast.2009.08210#.W5eJjOgzYuU)), is asymptotically equivalent to the classical version of R² for linear models.

# Arguments
- `model`: A `GeneralizedLinearModel`.

# References
- Tjur, T. (2009). Coefficients of determination in logistic regression models—A new proposal: The coefficient of discrimination. The American Statistician, 63(4), 366-372.

# Examples
```jldoctest
using GLM, DataFrames, Psycho

model = glm(@formula(y ~ Var1), DataFrame(y=[0, 0, 1, 1], Var1=[1, 2, 2, 4]), GLM.Binomial())
r2_tjur(model)

# output
0.5
```
"""
function r2_tjur(model::StatsModels.DataFrameRegressionModel{<:GLM.GeneralizedLinearModel})
    data = model_data(model)
    outcome = values(model_description(model))["Outcome"]

    Average_1 = Statistics.mean(round.(GLM.predict(model, data[data[outcome] .== 1.0, :])))
    Average_0 = Statistics.mean(round.(GLM.predict(model, data[data[outcome] .== 0.0, :])))
    D = abs(Average_1 - Average_0)
    return D
end


# http://rsif.royalsocietypublishing.org/content/14/134/20170213
# https://github.com/cran/MuMIn/blob/master/R/r.squaredGLMM2.R
# https://github.com/strengejacke/sjstats/blob/master/R/r2.R#L445
# r2glmm
