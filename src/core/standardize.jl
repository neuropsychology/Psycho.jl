import Statistics, DataFrames, StatsBase


"""
    standardize(X; robust::Bool=false)

Standardize (scale and reduce, Z-score) X so that the variables are expressed in terms of standard deviation (*i.e.*, mean = 0, SD = 1).

# Arguments
- `X`: Array or DataFrame.
- `robust::Bool`: If true, the standardization will be based on `median` and [`mad`](@ref) instead of `mean` and `sd` (default).

!!! note

    **Ideas / help required:**
    - Deal with missing values (See [#4](https://github.com/neuropsychology/Psycho.jl/issues/4))

# Examples
```jldoctest
standardize([1, 2, 3])

# output

3-element Array{Float64,1}:
 -1.0
  0.0
  1.0
```
"""
function standardize end





"""
    standardize!(X; robust::Bool=false)

In-place version of [`standardize`](@ref).
"""
function standardize! end






function standardize(X::Array{<:Number}; robust::Bool=false)

    if robust == false
        z = (X .- Statistics.mean(X, dims=1)) ./ Statistics.std(X, dims=1)
    else
        z = (X .- Statistics.median(X, dims=1)) ./ mapslices(x -> StatsBase.mad(x, normalize=true), X, dims=1)
    end
    return z
end


StatsBase.mad(skipmissing([1, 2, 3, missing]))

function standardize(X::Vector{<:Union{Missing, Number}}; robust::Bool=false)

    complete = collect(skipmissing(X))

    if robust == false
        z = (X .- Statistics.mean(complete)) ./ Statistics.std(complete)
    else
        z = (X .- Statistics.median(complete)) ./ StatsBase.mad(complete, normalize=true)
    end
    return z
end




function standardize!(X::Array{<:Union{Missing, Number}}; robust=false)
    X[:] = standardize(X, robust=robust)
end






function standardize!(X::DataFrames.DataFrame; robust=false)
    for (colname, col) in DataFrames.eachcol(X)
        if eltype(col) <: Union{Missing, Number}
            X[colname] = standardize(col)
        end
    end
end




function standardize(X::DataFrames.DataFrame; robust=false)
    df = copy(X)
    standardize!(df; robust=robust)
    return df
end
