import Statistics, DataFrames, StatsBase, GLM


data = simulate_data_logistic([0.1, 0.5], n=100)
model = GLM.glm(GLM.@formula(y ~ Var1 + Var2), data, GLM.Binomial())

model.model.rr.mu
GLM.fitted(model)
GLM.model_response(model)
fieldnames(model.model)
model.mf

# https://www.jstor.org/stable/pdf/25652317.pdf?casa_token=wzZ_TvA39rEAAAAA:cAFFDx4FoHxdVgxn5nZG-hhvU3FycqRbpHlwe__DlWi-MVqxcdeZvmlTraylxsobzI5lBieLLpLuT4ii1-K72GdDBFzCt6v-32TdTApBZCxL-XITbpff
function r2_tjur()
    Average_1 = Statistics.mean(round.(GLM.predict(model, data[data[:y] .== 1.0, :])))
    Average_0 = Statistics.mean(round.(GLM.predict(model, data[data[:y] .== 0.0, :])))

end


# http://rsif.royalsocietypublishing.org/content/14/134/20170213
# https://github.com/cran/MuMIn/blob/master/R/r.squaredGLMM2.R
# r2glmm
