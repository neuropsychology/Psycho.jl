# API

Details about Psycho's functions.


## Report

```@docs
report(df::DataFrames.DataFrame; kwargs...)
```


## Core

```@docs
standardize
```

```@docs
perfectNormal(n::Int=100, mean::Number=0, sd::Number=1)
```

## Interpret

```@docs
Rules(breakpoints::AbstractVector, labels::AbstractVector, iflower::Bool=true)
```

```@docs
interpret(x::Real, rules::Rules)
```

```@docs
interpret_p(p::Number; alpha::Number=0.05)
```

```@docs
format_p(p::Number; stars::Bool=false)
```

## Simulate

### Data

```@docs
simulate_data_correlation
```

## SDT

```@docs
sdt_indices(hit::Int, fa::Int, miss::Int, cr::Int; adjusted::Bool=true)
```

### Misc

```@docs
simulate_coefs_correlation(coefs_mean::Number=0.1; coefs_sd::Number=0.1, n::Int=10)
```

```@docs
simulate_groupnames(n::Int; nchar::Int=2)
```




