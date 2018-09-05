# Home

Welcome to Psycho's for Julia documentation.


!!! note

    The package is not released yet.
    
    
## Status and News

- 2018/09/02: Initial release of the documentation.

## Quick Example

```julia
using GLM, Psycho

# Simulate some data
data = simulate_data_correlation([[0.3], [0.1]])

# Standardize the results
standardize!(data)

# Describe the data
report(data)
```
```
The data contains 200 observations ofthe following variables:
  - y (Mean = 0 ± 1.0 [-2.79, 3.28])
  - Var1 (Mean = 0 ± 1.0 [-3.37, 3.1])  
  - Group (1RX, 50.0%; 2UA, 50.0%)
```

## Content

```@contents
Pages = [
    "man/API.md",
    "man/about.md"
]
Depth = 1
```
