import DataFrames




"""
    report(df::DataFrames.DataFrame; kwargs...)

Describe a DataFrame.

# Arguments
- `df`: DataFrame.
- `silent::Bool`: Print the output.

!!! note

    **Ideas / help required:**
    - Add more indices (See [#19](https://github.com/neuropsychology/Psycho.jl/issues/19))
    - Deal with SubDataFrames (See [#20](https://github.com/neuropsychology/Psycho.jl/issues/20))

# Examples
```jldoctest
julia> report(simulate_data_correlation([[0.1], [0.2]]))
The data contains 200 observations of the following variables:
[...]
```
"""
function report(df::DataFrames.DataFrame; kwargs...)
    text = "The data contains $(DataFrames.nrow(df)) observations of the following variables:"

    for (colname, var) in DataFrames.eachcol(df)
        description = report(var; kwargs...)
        text = text * "\n  - " * String(colname) * " (" * description.text * ")"
    end

    return Report(text=text)
end
