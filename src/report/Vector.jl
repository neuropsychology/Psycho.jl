import Statistics, DataFrames, StatsBase




function fix_variable_type(x::Vector)
  if all(isa.(x, Number))
    x = Vector{Number}(x)
  elseif all(isa.(x, String))
    if length(unique(x)) < 7
      x = DataFrames.categorical(x)
    else
      x = Vector{String}(x)
    end
  else
    @warn "Undetected variable type."
  end
  return x
end






function report(x::Array{String, 1}; kwargs...)
    # TODO: Sort by frequency and display the n firsts
    description = "$(length(unique(x))) different entries"
    return description
end





function report(x::Array{Any, 1}; missing_in_percentage=true, kwargs...)
    n_missings = sum(ismissing.(x))
    if n_missings == 0
        x = fix_variable_type(x)
        description = report(x; kwargs...)
        return description
    end
    if missing_in_percentage == true
        n_missings = "$(round(n_missings / length(x), digits=2))%"
    end
    x = collect(skipmissing(x))
    description = report(x; kwargs...)
    description *= ", missing = $n_missings"
    return description
end





function report(x::DataFrames.CategoricalArray{Any, 1}; percentage::Bool=true, kwargs...)
    description = Vector{String}()
    for level in DataFrames.levels(x)
        if percentage == true
            n = ", $(round(sum(x .== level)/length(x)*100, digits=2))%"
        else
            n = ", n = $(sum(x .== level))"
        end
        push!(description, (level * n))
    end
    description = join(description, "; ")

    return description
end





function report(x::Array{<:Number, 1}; median::Bool=false, dispersion::Bool=true, range::Bool=true, kwargs...)

    # Centrality
    if median == false
        var_centrality = "Mean = $(round(Statistics.mean(x), digits=2))"
    else
        var_centrality = "Median = $(round(Statistics.median(x), digits=2))"
    end

    # Dispersion
    if dispersion == true
        if median == true
            var_dispersion = " ± $(round(StatsBase.mad(x, normalize=true), digits=2))"
        else
            var_dispersion = " ± $(round(Statistics.std(x), digits=2))"
        end
    else
        var_dispersion = ""
    end

    # Range
    if range == true
        var_range = " [$(round(minimum(x), digits=2)), $(round(maximum(x), digits=2))]"
    else
        var_range = ""
    end

    description = var_centrality * var_dispersion * var_range
    return description
end
