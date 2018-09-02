import Statistics, DataFrames, StatsBase


"""
    standardize(X::Array{<:Number}; robust::Bool=false)

Standardize (scale and reduce X).

This is a more extensive documentation.


# Arguments
- `X::Array{<:Number}`: Array or DataFrame.
- `robust::Bool`: Based on `mean` and `sd` (default) or on `median` and `mad`.

# Examples
```jldoctest
julia> standardize([1, 2, 3])
3-element Array{Float64,1}:
 -1.0
  0.0
  1.0
```
"""
function standardize(X::Array{<:Number}; robust::Bool=false)
    if robust == false
        std = (X .- Statistics.mean(X, dims=1)) ./ Statistics.std(X, dims=1)
    else
        std = (X .- Statistics.median(X, dims=1)) ./ mapslices(x -> StatsBase.mad(x, normalize=true), X, dims=1)
    end
end
