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
julia> simulate_coefs_correlation(0.5)
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
    simulate_data_correlation(coefs::Vector{<:Number}; n::Int=100, noise::Number=0.0)

Generate a DataFrame of correlated variables.

# Arguments
- `coefs::Vector{<:Number}`: Correlation coefficients.
- `n::Int`: Number of observations.
- `noise::Number`: The SD of the random gaussian noise.

!!! note

    **Ideas / help required:**
    - Different group sizes (See [#9](https://github.com/neuropsychology/Psycho.jl/issues/9))

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





function simulate_data_correlation(coefs::Number; n::Int=100, noise::Number=0.0)
  simulate_data_correlation([coefs], n=n, noise=noise)
end





function simulate_data_correlation(coefs::Vector{<:Vector}, groupnames::Vector; n::Int=100, noise::Number=0.0)

  # Check and fix length difference
  if all(y -> y == first(length.(coefs)), length.(coefs)) == false
    longest = maximum(length.(coefs))
    for (i, groupcoefs) in enumerate(coefs)
      if length(groupcoefs) < longest
        coefs[i] = vcat(groupcoefs, fill(0.0, longest-length(groupcoefs)))
      end
    end
  end

  # Run by group
  data = DataFrames.DataFrame(Array{Float64}(undef, 0, length(coefs[1])+2))
  for (i, groupcoefs) in enumerate(coefs)
    group = simulate_data_correlation(groupcoefs, n=n, noise=noise)
    group[:Group] = groupnames[i]

    DataFrames.names!(data, names(group))
    data = vcat(data, group)
  end

  # Convert to categorical
  data[:Group] = DataFrames.categorical(data[:Group])

  return data
end





function simulate_data_correlation(coefs::Vector{<:Vector}; n::Int=100, noise::Number=0.0, kwargs...)
  groupnames = simulate_groupnames(length(coefs); kwargs...)
  data = simulate_data_correlation(coefs, groupnames, n=n, noise=noise)
end
