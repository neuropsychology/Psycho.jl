import Statistics, GLM, DataFrames



"""
    datagrid(df::DataFrames.DataFrame; cols=:all, n::Int=10, kwargs...)

Create a reference grid of data.


# Arguments
- `df`: A `DataFrame` (can be a `StatsModel`).
- `cols`: The target columns. The rest will be maintained "fixed".
- `n`: For numeric targets columns, what desired length (controls the spacing).
- `fix_num`: How to fix the numeric variables. Can be a function or a number.
- `fix_fac`: How to fix the factors. Should be a String indicating an existing level.

# Examples
```julia
df = simulate_data_correlation([[0.2, 0.5], [0.4, 0.2]])

grid = datagrid(df, n=3)
```
"""
function datagrid(df::DataFrames.DataFrame; cols=:all, n::Int=10, kwargs...)
    if cols == :all
        cols = names(df)
    elseif isa(cols, Vector{String})
        cols = Symbol.(cols)
    elseif isa(cols, Vector{Int})
        cols = names(df)[cols]
    elseif !isa(cols, Vector{Symbol})
        throw(ArgumentError("`cols` must be Vector{String}, Vector{Int}, Vector{Symbol} or :all."))
    end

    # Split data
    df_target = df[cols]
    df_to_keep_fixed = df[setdiff(names(df), cols)]

    # Create grid
    grid = colwise(x -> datagrid(x, n=n), df_target)
    grid = vec(collect(Base.product(grid...)))
    grid = DataFrame(collect.([ getindex.(grid,t) for t in 1:length(grid[1]) ]), names(df_target))

    # Add fixed
    df_to_keep_fixed = keep_fixed(df_to_keep_fixed, n=nrow(grid); kwargs...)
    grid = hcat(grid, df_to_keep_fixed)

    return grid
end






function datagrid(model::StatsModels.DataFrameRegressionModel; cols=:all, n::Int=10, kwargs...)
    data = model_data(model)
    # Select only Predictors
    data = data[values(model_description(model))["Predictors"]]
    grid = datagrid(data, cols=cols, n=n; kwargs...)
    return grid
end








# datagrid: Vectors ------------------------------------------------------------------------


function datagrid(X::AbstractVector{<:Union{Real, Missing}}; n::Int=10)
    X = skipmissing(X)
    X = collect(range(minimum(X), stop=maximum(X), length=n))
end






function datagrid(X::DataFrames.CategoricalVector; n=nothing)
    X = levels(X)
end





function datagrid(X::AbstractVector{<:Union{String, Missing}}; n=nothing)
    X = unique(skipmissing(X))
end









# keep_fixed -------------------------------------------------------------------------------




function keep_fixed(X::AbstractVector{<:Union{Real, Missing}}; fix_num=Statistics.mean, kwargs...)
    if isa(fix_num, Number)
        return fix_num
    else
        X = skipmissing(X)
        fix_num(X)
    end
end






function keep_fixed(X::DataFrames.CategoricalVector; fix_fac=1, kwargs...)
    if isa(fix_fac, Int)
        return levels(X)[fix_fac]
    elseif isa(fix_fac, String)
        if fix_fac in levels(X)
            return fix_fac
        else
            throw(ArgumentError("`fix_fac` must be an existing level."))
        end
    else
        throw(ArgumentError("`fix_fac` must be an Int or a String."))
    end
end





function keep_fixed(X::AbstractVector{<:Union{String, Missing}}; fix_fac=1, kwargs...)
    if isa(fix_fac, Int)
        X = skipmissing(X)
        return unique(X)[fix_fac]
    elseif isa(fix_fac, String)
        return fix_fac
    else
        throw(ArgumentError("`fix_fac` must be an Int or a String."))
    end
end




function keep_fixed(df::DataFrames.DataFrame; fix_num=Statistics.mean, fix_fac=1, n::Int=1, kwargs...)
    fixed = colwise(x -> keep_fixed(x, fix_num=fix_num, fix_fac=fix_fac; kwargs...), df)
    fixed = DataFrame([repeat([x], n) for x in fixed], names(df))
    return fixed
end
