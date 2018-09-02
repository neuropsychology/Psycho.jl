module Psycho

export
    standardize,
    standardize!,
    simulate_groupnames


include("core/standardize.jl")
include("simulate/groupnames.jl")
# include("simulate/correlation.jl")

end # module
