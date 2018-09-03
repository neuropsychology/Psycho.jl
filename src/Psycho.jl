module Psycho

export
    standardize,
    standardize!,
    perfectNormal,
    Rules,
    interpret,
    interpret_p,
    format_p,
    simulate_groupnames,
    simulate_coefs_correlation,
    simulate_data_correlation


include("core/standardize.jl")
include("core/perfectNormal.jl")

include("interpret/interpret.jl")
include("interpret/pvalue.jl")

include("simulate/groupnames.jl")
include("simulate/data_correlation.jl")

include("sdt/basics.jl")
end # module
