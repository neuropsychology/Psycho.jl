<p align="center"><a href=https://neuropsychology.github.io/Psycho.jl/latest/><img src="docs/src/assets/logo_Psycho.jl.png" width="500" align="center" alt="psycho logo julia package"></a></p>

*<h4 align="center">The Julia Toolbox for Psychological Science</h2>*

# Psycho.jl
[![Build Status](https://travis-ci.org/neuropsychology/Psycho.jl.svg?branch=master)](https://travis-ci.org/neuropsychology/Psycho.jl)
[![Build status](https://ci.appveyor.com/api/projects/status/313hx3rmmc1swckg?svg=true)](https://ci.appveyor.com/project/DominiqueMakowski/psycho-jl)
[![](https://img.shields.io/badge/docs-latest-blue.svg)](https://neuropsychology.github.io/Psycho.jl/latest/)
[![codecov](https://codecov.io/gh/neuropsychology/Psycho.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/neuropsychology/Psycho.jl)



# Goal

***"From Julia to Manuscript"***

`Psycho`'s primary goal is to fill the gap between Julia's output and the formatted result description of your manuscript, with the automated use of **best practices** guidelines, ensuring standardization and quality of results reporting.
It also provides useful tools and functions for psychologists, neuropsychologists and neuroscientists for their everyday data analyses.

# Contribute

`Psycho.jl` **is a young package in need of affection**. You can easily hop aboard the developpment of this open-source software and improve psychological science by doing the following:

- Create or check existing <a href=https://github.com/neuropsychology/Psycho.jl/issues><img src="docs/src/assets/issue_bug.png" height="25"></a> issues to report, replicate, understand or solve some bugs.
- Create or check existing <a href=https://github.com/neuropsychology/Psycho.jl/issues><img src="docs/src/assets/issue_featureidea.png" height="25"></a> issues to suggest or discuss a new feature.
- Check existing <a href=https://github.com/neuropsychology/Psycho.jl/issues><img src="docs/src/assets/issue_help.png" height="25"></a> issues to see things that we'd like to implement, but where help is needed to do it.
- Check existing <a href=https://github.com/neuropsychology/Psycho.jl/issues><img src="docs/src/assets/issue_opinion.png" height="25"></a> issues to give your opinion and participate in package's design discussions.

Don't be shy, try to code and submit a pull request (PR). Even if unperfect, we will help you make it great! All contributors will be very graciously rewarded someday :smirk:.


# Installation

```
pkg> add https://github.com/neuropsychology/Psycho.jl.git
```


# Documentation

- Reports: Interpret and report your models
- Effect Sizes: Rules of thumb and interprettation
- Signal Detection Theory: SDT's related indices



# Examples

## Report all the things <a href=https://neuropsychology.github.io/Psycho.jl/latest/><img src="https://www.memecreator.org/static/images/templates/2776.jpg" height="100"></a>

### Data

```julia
using Psycho

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

### Linear Models (LM)

```julia
using GLM

# Fit a Linear Model
model = lm(@formula(y ~ Var1 * Group), data)

# Report the results
results = report(model)
```
```
We fitted a linear regression to predict y with Var1 and Group (Formula: y ~ 1 + Var1 + Group + Var1 & Group). The model's explanatory power (R²) is of 0.09 (adj. R² = 0.07). The model's intercept is at 0.0. Within this model:
  - Var1 is not significant (beta = 0.1, t(196) = 1.03, 95% [-0.09; -0.09], p > .1)
  - Group: 2PN is not significant (beta = 0, t(196) = 0, 95% [-0.27; -0.27], p > .1)
  - Var1 & Group: 2PN is significant (beta = 0.3, t(196) = 2.2, 95% [0.03; 0.03], p < .01)
```

## Signal Detection Theory (SDT)

```julia
sdt_indices(hit=6, fa=7, miss=8, cr=9)
```
```
Dict{String,Float64} with 5 entries:
  "bpp"    => -0.0711812
  "c"      => 0.191778
  "aprime" => 0.527793
  "dprime" => -0.0235319
  "beta"   => 0.995497
```
