module Psycho

export
    standardize,
    standardize!,
    perfectNormal,
    r2_tjur,

    Rules,
    interpret,
    interpret_p,
    format_p,

    simulate_groupnames,
    simulate_coefs_correlation,
    simulate_data_correlation,
    simulate_data_logistic,

    sdt_indices,

    Report,
    report,
    table,
    values


include("core/standardize.jl")
include("core/perfectNormal.jl")
include("core/R2.jl")

include("interpret/interpret.jl")
include("interpret/pvalue.jl")

include("simulate/data_groups.jl")
include("simulate/data_correlation.jl")
include("simulate/data_logistic.jl")

include("sdt/basics.jl")

include("report/report.jl")
include("report/Vector.jl")
include("report/DataFrame.jl")
include("report/LM.jl")
include("report/GLM.jl")

end # module
