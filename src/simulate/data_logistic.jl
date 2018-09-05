import Distributions, Random, StatsFuns



"""
    simulate_data_logistic(coefs; n::Int=100, noise::Number=0.0, groupnames=:random)

Generate a DataFrame of variables related a binary dependent variable by specified regression `coefs`.

# Multiple Variables / Groups
- If `coefs` is a vector (*e.g., `[0.1, 0.2]`), the DataFrame will contain `length(coefs)` variables (`Var1, Var2, ...`). Altough uncorrelated between them, they are  correlated to the outcome (`y`) by the specified coefs.
- If `coefs` is a vector of vectors (*e.g., `[[0.1], [0.2]]`), it will create `length(coefs)` groups, *i.e.*, stacked DataFrames with a correlation between the variables and the outcome varying between groups. It is possible to specify the `groupnames`.

# Arguments
- `coefs`: Regression coefficients. Can be a number, a vector of numbers or a vector of vectors.
- `n::Int`: Number of observations.
- `noise::Number`: The SD of the random gaussian noise.
- `groupnames::Vector`: Vector of group names (default to `:random`).
- `kwargs...`: Arguments to pass to other functions.

!!! note

    **Ideas / help required:**
    - Different group sizes (See [#9](https://github.com/neuropsychology/Psycho.jl/issues/9))

# Examples
```jldoctest
simulate_data_logistic(0.2)

# output

100×2 DataFrames.DataFrame
[...]
```
"""
function simulate_data_logistic end





function simulate_data_logistic(coefs::Vector{<:Number}; n::Int=100, noise::Number=0.0)

    n_var = length(coefs)
    X = standardize(randn(n, n_var))
    Z = X * coefs .+ 1

    p = StatsFuns.logistic.(Z)
    y = Float64.(rand(length(p)) .< p)

    # Add noise
    if noise != 0
      X = X .+ Random.rand(Distributions.Normal(0, noise), n, n_var)
    end

    data = DataFrames.DataFrame(hcat(y, X),
      Symbol.(vcat(["y"], "Var" .* string.(1:n_var))))
    return data

end






function simulate_data_logistic(coefs::Number; n::Int=100, noise::Number=0.0)
  simulate_data_logistic([coefs], n=n, noise=noise)
end





function simulate_data_logistic(coefs::Vector{<:Vector}; n::Int=100, noise::Number=0.0, groupnames=:random, kwargs...)
  data = simulate_data_groups(simulate_data_logistic, coefs=coefs, n=n, noise=noise, groupnames=groupnames, kwargs...)
  return data
end
