import Distributions

"""
    perfectNormal(n::Int, mean::Number=0, sd::Number=1)

Generate an almost-perfect normal distribution of size `n`.

# Arguments
- `n::Int`: Length of the vector.
- `mean::Number`: Mean of the vector.
- `sd::Number`: SD of the vector.

# Examples
```julia
perfectNormal(10, 0, 1)
```
"""
function perfectNormal(n::Int, mean::Number=0, sd::Number=1)
    x = Distributions.quantile.([Distributions.Normal(mean, sd)],
                                range(1/n, stop=1-1/n, length=n))
    return x
end
perfectNormal(; n::Int, mean::Number=0, sd::Number=1) = perfectNormal(n, mean, sd)
