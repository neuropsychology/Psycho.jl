import DataFrames





function report(df::DataFrames.DataFrame; kwargs...)
    println("The data contains $(DataFrames.nrow(df)) observations of the following variables:")

    for (colname, var) in DataFrames.eachcol(df)
        description = report(var; kwargs...)
        description = "  - " * String(colname) * " (" * description * ")"
        println(description)
    end
end
