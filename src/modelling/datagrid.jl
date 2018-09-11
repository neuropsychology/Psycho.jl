using GLM, DataFrames, Psycho


data = simulate_data_correlation([[0.2], [0.4]])


model = lm(@formula(y ~ Var1), DataFrame(y=[0, 0, 1, 1], Var1=[1, 2, 2, 4]), GLM.Binomial())

X = data[:Var1]

function datagrid(X::Vector{:<Number}, n::Int=10)
    X = collect(range(minimum(X), stop=maximum(X), length=n))
end
