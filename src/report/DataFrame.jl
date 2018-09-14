import DataFrames




"""
    report(df::DataFrames.DataFrame; kwargs...)

Describe the variables in a DataFrame.

# Arguments
- `df`: DataFrame.
- `missing_percentage::Bool`: Show missings by percentage (default) or number.
- `levels_percentage::Bool`: Show factor levels by percentage (default) or number.
- `median::Bool`: Show `mean` and `sd` (default) or `median` and `mad`.
- `dispersion::Bool`: Show dispersion (`sd` or `mad`).
- `range::Bool`: Show range.
- `n_strings::Int`: Number of different string elements to show.


!!! note

    **Ideas / help required:**
    - Add more indices (See [#19](https://github.com/neuropsychology/Psycho.jl/issues/19))
    - Deal with SubDataFrames (See [#20](https://github.com/neuropsychology/Psycho.jl/issues/20))

# Examples
```julia
report(simulate_data_correlation([[0.1], [0.2]]))
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
