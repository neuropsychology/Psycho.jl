import LinearAlgebra, Distributions, Random, Statistics, DataFrames




"""
    simulate_coefs_correlation(coefs_mean::Number=0.1; coefs_sd::Number=0.1, n::Int=10)

Generate a vector of random correlation coefficients from a normal distribution.

# Arguments
- `coefs_mean::Number`: Mean of the normal distribution from which to get the coefs.
- `coefs_sd::Number`: SD of the normal distribution.
- `n::Int`: Number of coefficients.

# Examples
```jldoctest
simulate_coefs_correlation(0.5)

# output

10-element Array{Array{Float64,1},1}:
[...]
```
"""
function simulate_coefs_correlation(coefs_mean::Number=0.1; coefs_sd::Number=0.1, n::Int=10)
  # Generate outcome
  coefs = Random.rand(Distributions.Normal(coefs_mean, coefs_sd), n)
  coefs = [x = [x] for x in coefs]
end







"""
    simulate_data_correlation(coefs; n::Int=100, noise::Number=0.0, groupnames=:random)

Generate a DataFrame of correlated variables.

# Multiple Variables / Groups
- If `coefs` is a vector (*e.g., `[0.1, 0.2]`), the DataFrame will contain `length(coefs)` variables (`Var1, Var2, ...`). Altough uncorrelated between them, they are  correlated to the outcome (`y`) by the specified coefs.
- If `coefs` is a vector of vectors (*e.g., `[[0.1], [0.2]]`), it will create `length(coefs)` groups, *i.e.*, stacked DataFrames with a correlation between the variables and the outcome varying between groups. It is possible to specify the `groupnames`.

# Arguments
- `coefs`: Correlation coefficients. Can be a number, a vector of numbers or a vector of vectors.
- `n::Int`: Number of observations.
- `noise::Number`: The SD of the random gaussian noise.
- `groupnames::Vector`: Vector of group names (default to `:random`).
- `kwargs...`: Arguments to pass to other functions.

!!! note

    **Ideas / help required:**
    - Different group sizes (See [#9](https://github.com/neuropsychology/Psycho.jl/issues/9))
    - Bug in some cases (*e.g.*, `simulate_data_correlation([0.2, 0.9, 0.5])`) related to failure in Cholesky factorization (See [#11](https://github.com/neuropsychology/Psycho.jl/issues/11))

# Examples
```jldoctest
simulate_data_correlation(0.2)

# output

100×2 DataFrames.DataFrame
[...]
```
"""
function simulate_data_correlation end






function simulate_data_correlation(coefs::Vector{<:Number}; n::Int=100, noise::Number=0.0)

  # Generate outcome
  y = standardize(Random.rand(Distributions.Normal(0, 1), n))



  n_var = length(coefs)
  X = standardize(Random.rand(Distributions.Normal(0, 1), n, n_var))
  X = hcat(y, X)

  # find the current correlation matrix
  cor_structure = Statistics.cov(X)
  chol = LinearAlgebra.cholesky(cor_structure).U

  # cholesky decomposition to get independence
  X = X / chol

  # create new correlation structure (zeros can be replaced with other r vals)
  coefs_structure = Matrix{Float64}(LinearAlgebra.I, n_var+1, n_var+1)
  coefs_structure[1, 2:end] = coefs
  coefs_structure[2:end, 1] = coefs

  X = X * LinearAlgebra.cholesky(coefs_structure).U
  X = X * Statistics.std(y) .+ Statistics.mean(y)

  X = X[:, 2:end]

  # Add noise
  if noise != 0
    y = y .+ Random.rand(Distributions.Normal(0, noise), n)
  end

  data = DataFrames.DataFrame(hcat(y, X),
    Symbol.(vcat(["y"], "Var" .* string.(1:n_var))))
  return data
end





function simulate_data_correlation(coefs::Number; n::Int=100, noise::Number=0.0)
  simulate_data_correlation([coefs], n=n, noise=noise)
end








function simulate_data_correlation(coefs::Vector{<:Vector}; n::Int=100, noise::Number=0.0, groupnames=:random, kwargs...)
  data = simulate_data_groups(simulate_data_correlation, coefs=coefs, n=n, noise=noise, groupnames=groupnames, kwargs...)
  return data
end
