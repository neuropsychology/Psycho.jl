import LinearAlgebra, Distributions, Random, Statistics, DataFrames






"""
    simulate_data_correlation(coefs::Vector{<:Number}; n::Int=100, noise::Number=0.0)

Generate a DataFrame of correlated variables.

# Arguments
- `coefs::Vector{<:Number}`: Correlation coefficients.
- `n::Int`: Number of observations.
- `noise::Number`: The SD of the random gaussian noise.

# Examples
```jldoctest
julia> simulate_data_correlation([0.2])
100×2 DataFrames.DataFrame
[...]
```
"""
function simulate_data_correlation(coefs::Vector{<:Number}; n::Int=100, noise::Number=0.0)

  # Sanity checks
  if all(elem isa Number for elem in coefs) == false
    throw(ArgumentError("Coefs should all be numbers"))
  end

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
