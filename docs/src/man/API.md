# API

Details about Psycho's functions.


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


## Simulate

### Data

```@docs
simulate_data_correlation
```


### Misc

```@docs
simulate_coefs_correlation(coefs_mean::Number=0.1; coefs_sd::Number=0.1, n::Int=10)
```

```@docs
simulate_groupnames(n::Int; nchar::Int=2)
```




