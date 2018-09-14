# Home




Welcome to Psycho's for Julia documentation.


!!! note

    The package is not released yet. Help for its development is very much appreciated.


## Installation

```
pkg> add https://github.com/neuropsychology/Psycho.jl.git
```

## Goal

`Psycho`'s primary goal is to fill the gap between Julia's output and the formatted result description of your manuscript, with the automated use of **best practices** guidelines, ensuring standardization and quality of results reporting.
It also provides useful tools and functions for psychologists, neuropsychologists and neuroscientists for their everyday data analyses.


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
The data contains 200 observations of the following variables:
  - y (Mean = 0 ± 1.0 [-2.22, 2.6])
  - Var1 (Mean = 0 ± 1.0 [-2.77, 3.19])
  - Group (1HK, 50.0%; 2YP, 50.0%)
```

```julia
using GLM

# Fit a Linear Model
model = lm(@formula(y ~ Var1 * Group), data)

# Report the results
results = report(model)
```
```
We fitted a linear regression to predict y with Var1 and Group (Formula: y ~ 1 + Var1 + Group + Var1 & Group).
The model's explanatory power (R²) is of 0.05 (adj. R² = 0.04). The model's intercept is at -0.0. Within this model:
  - Var1 is significant (β = 0.3, t(196) = 3.05, 95% [0.11; 0.49], p < .01)
  - Group: 2YP is not significant (β = 0.0, t(196) = 0.0, 95% [-0.27; 0.27], p > .1)
  - Var1 & Group: 2YP is not significant (β = -0.2, t(196) = -1.44, 95% [-0.47; 0.07],
p > .1)
```

