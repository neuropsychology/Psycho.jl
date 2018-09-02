
@test length(simulate_groupnames(10)) == 10

data = simulate_data_correlation([0.2])
@test cor(data[:y], data[:Var1]) ≈ 0.2
