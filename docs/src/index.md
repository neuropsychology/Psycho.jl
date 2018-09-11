# Home

Welcome to Psycho's for Julia documentation.


!!! note

    The package is not released yet. Help for its developpment is very much appreciated.


## Status and News

- 2018/09/02: Initial release of the documentation.

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
The data contains 200 observations ofthe following variables:
  - y (Mean = 0 ± 1.0 [-2.79, 3.28])
  - Var1 (Mean = 0 ± 1.0 [-3.37, 3.1])  
  - Group (1RX, 50.0%; 2UA, 50.0%)
```

```julia
using GLM

# Fit a Linear Model
model = lm(@formula(y ~ Var1 * Group), data)

# Report the results
results = report(model)
```
```
We fitted a linear regression to predict y with Var1 and Group (Formula: y ~ 1 + Var1 + Group + Var1 & Group). The model's explanatory power (R²) is of 0.05 (adj. R² = 0.04). The model's intercept is at -0.0. Within this model:
  - Var1 is significant (coef = 0.3, t(196) = 3.05, 95% [0.11; 0.49], p < .01)
  - Group: 2LH is not significant (coef = 0.0, t(196) = 0.0, 95% [-0.27; 0.27], p > .1)
  - Var1 & Group: 2LH is not significant (coef = -0.2, t(196) = -1.44, 95% [-0.47; 0.07], p > .1)
```

## Content

```@contents
Pages = [
    "man/API.md",
    "man/about.md"
]
Depth = 1
```
