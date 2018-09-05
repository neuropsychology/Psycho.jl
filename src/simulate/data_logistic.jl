import Distributions, Random

# https://stats.stackexchange.com/questions/46523/how-to-simulate-artificial-data-for-logistic-regression


# coefs = [0.2]
# data = simulate_data_correlation(coefs; n=100, noise=0.0)
# data[:y] = 1 ./ (1+exp.(-1 * data[:y]))  # pass through an inv-logit function
# data[:y] = [Random.rand(Distributions.Bernoulli(x)) for x in data[:y]]
#
#
# using GLM
#
# glm(@formula(y ~ Var1), data, Binomial(), LogitLink())
