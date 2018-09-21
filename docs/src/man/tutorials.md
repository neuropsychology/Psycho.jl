# Tutorials

## Design

The package is centered around one function, `report()`, which goal is to transform a Julia object into readable text. It also provides useful general and domain-specific functions to efficiently process psychological data.


## Simulate some Data

Let's start by simulating some correlated data:

```julia
using Psycho  # Import the Psycho package

# Simulate some data wit ha specified correlation coefficient (0.3)
data = simulate_data_correlation(0.3)

# Describe the data
report(data)
```
```
The data contains 100 observations of the following variables:
  - y (Mean = 0 ± 1.0 [-2.32, 2.6])
  - Var1 (Mean = 0 ± 1.0 [-3.16, 2.01])
```

!!! note

    The results reported here and those in your console might be not be exactly the same. This is due to the random nature of some functions that generates different results at each run.



As we can see, we have successfully generated two numeric variables, `y` and `Var1`. Moreover, the `report()` function works on a DataFrame and provide a quick and convenient description of your data.


!!! tip

    This `report` is quite flexible. For example, running `report(data, median=true, levels_percentage=false)` will display the median instead of the mean and the raw count of factor levels insteand of the percentage. See the [documentation](https://neuropsychology.github.io/Psycho.jl/latest/man/API.html#Psycho.report-Tuple{DataFrame}) for details.


## Fit a Linear Regression (LM)


```julia
using GLM  # Import the package for fitting GLMs

model = lm(@formula(y ~ Var1), data)
report(model, std_coefs=false)
```
```
We fitted a linear regression to predict y with Var1 (Formula: y ~ 1 + Var1). The model's explanatory power (R²) is
of 0.09 (adj. R² = 0.08). The model's intercept is at -0.0. Within this model:
  - Var1 is significant (Coef = 0.3, t(98) = 3.11, 95% CI [0.11; 0.49], p < .01) and can be considered as small (Std. Coef = 0.3).
```

Applying the `report()` function to a linear model returns the model's formula and a general index of the model's predictive performance (here, the normal and adjusted R²). It also reports all the parameters (the "effects" in psychology) and their characteristics: the coefficient (*β*), the statistic (the *t* value), degrees of freedom, the confidence interval and the *p* value. It also returns, by default, the standardized coefficients (which in, in this case, the same as  the raw one as our data was generated standardized). It is used as an index of *effect size* and interpreted with rules of thumb (Cohen's (1988) by default). In our example, the regression coefficient of `Var1` is indeed the one that we specified (`0.3`): everything worked correctly.


## Fit a Multiple GLM

Let's fit a more complex model involving more variables and a binomial outcome (made of zeros and ones).


```julia
# Simulate some data suited for logistic regression with multiple groups
data = simulate_data_logistic([[0.3, 0.5], [0.1, 0.3]])

# Describe the data
report(data)
```
```
The data contains 200 observations of the following variables:
  - y (Mean = 0.72 ± 0.45 [0.0, 1.0])
  - Var1 (Mean = 0 ± 1.01 [-2.37, 2.44])
  - Var2 (Mean = 0.06 ± 0.95 [-2.11, 2.67])
  - Group (1DS, 50.0%; 2QC, 50.0%)
```

We generated a dataset with one outcome (0 and 1), two numeric variables (`Var1` and `Var2`) and one factor (`Group`) with two levels. To fit a logistic model (a subtype of GLMs suited for binomial outcomes), we do as previously, but with writing `glm` instead of `lm` and adding an additional argument at the end to specify the `Binomial` nature of the model.

```julia
model = glm(@formula(y ~ Var1 + Var2 * Group), data, Binomial())
report(model)
```
```
We fitted a logistic regression to predict y with Var1, Var2 and Group (Formula: y ~ 1 + Var1 + Var2 + Group + Var2 & Group).
The model's explanatory power (Tjur's R²) is of 0.07. The model's intercept is at 1.42. Within this model:
  - Var1 is not significant (Coef = 0.25, z(195) = 1.42, 95% CI [-0.1; 0.59], p > .1) and can be considered as very small (Std. Coef = 0.25).
  - Var2 is not significant (Coef = 0.55, z(195) = 1.96, 95% CI [-0.0; 1.1], p = .05) and can be considered as very small (Std. Coef = 0.53).
  - Group: 2HV is not significant (Coef = -0.34, z(195) = -0.96, 95% CI [-1.03; 0.35], p > .1) and can be considered as very small (Std. Coef = -0.34).
  - Var2 & Group: 2HV is not significant (Coef = -0.01, z(195) = -0.03, 95% CI [-0.73; 0.7], p > .1) and can be considered as very small (Std. Coef = -0.01).
```

## Mixed Models

**WIP**

## Bayesian Models

**WIP**
