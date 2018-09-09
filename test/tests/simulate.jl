import Statistics

@test length(simulate_groupnames(10)) == 10
@test length(simulate_coefs_correlation(10)) == 10

# Correlation
data = simulate_data_correlation(0.2)
@test Statistics.cor(data[:y], data[:Var1]) ≈ 0.2

@test length(simulate_data_correlation([[0.2], [0.1]])) == 3
@test length(simulate_data_correlation([[0.2], [0.1, 0.3]], groupnames=["A", "B"], noise=0.3)) == 4

@test_throws ArgumentError simulate_data_correlation([[0.2], [0.1]], groupnames="Hello")
@test_throws ArgumentError simulate_data_correlation([[0.2], [0.1]], groupnames=["Hello"])

# Logistic
data = simulate_data_logistic(0.2)
@test length(unique(data[:y])) == 2

@test length(simulate_data_logistic([[0.2], [0.1]])) == 3
@test length(simulate_data_logistic([[0.2], [0.1, 0.3]], groupnames=["A", "B"], noise=0.3)) == 4

@test_throws ArgumentError simulate_data_logistic([[0.2], [0.1]], groupnames="Hello")
@test_throws ArgumentError simulate_data_logistic([[0.2], [0.1]], groupnames=["Hello"])
