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






function report(x::Vector{String}; n_strings::Int=4, kwargs...)
    # Sort by frequency
    sorted =first.(sort(collect(StatsBase.countmap(x)), by = i -> i[2], rev=true))
    if length(sorted) > n_strings
        sorted = "(" * join(sorted[1:n_strings], ", ") * ", ...)"
    else
        sorted = "(" * join(sorted, ", ", " and ") * ")"
    end

    text = "$(length(unique(x))) different entries " * sorted
    return Report(text=text)
end





function report(x::Vector{<:Any}; missing_percentage::Bool=true, kwargs...)
    n_missings = sum(ismissing.(x))
    if n_missings == 0
        x = fix_variable_type(x)
        text = report(x; kwargs...)
        return Report(text=text)
    end
    if missing_percentage == true
        n_missings = "$(round(n_missings / length(x), digits=2))%"
    end
    x = collect(skipmissing(x))
    text = report(x; kwargs...).text
    text *= ", missing = $n_missings"
    return Report(text=text)
end





function report(x::DataFrames.CategoricalVector; levels_percentage::Bool=true, kwargs...)
    text = string.(zeros(length(DataFrames.levels(x))))
    for (i, level) in enumerate(DataFrames.levels(x))
        if levels_percentage == true
            n = ", $(round(sum(x .== level)/length(x)*100, digits=2))%"
        else
            n = ", n = $(sum(x .== level))"
        end
        text[i] = level * n
    end
    text = join(text, "; ")

    return Report(text=text)
end





function report(x::Vector{<:Real}; median::Bool=false, dispersion::Bool=true, range::Bool=true, kwargs...)

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

    text = var_centrality * var_dispersion * var_range
    text = format_text(text)

    return Report(text=text)
end
