var documenterSearchIndex = {"docs": [

{
    "location": "index.html#",
    "page": "Home",
    "title": "Home",
    "category": "page",
    "text": ""
},

{
    "location": "index.html#Home-1",
    "page": "Home",
    "title": "Home",
    "category": "section",
    "text": "Welcome to Psycho\'s for Julia documentation.note: Note\nThe package is not released yet. Help for its development is very much appreciated."
},

{
    "location": "index.html#Installation-1",
    "page": "Home",
    "title": "Installation",
    "category": "section",
    "text": "pkg> add https://github.com/neuropsychology/Psycho.jl.git"
},

{
    "location": "index.html#Goal-1",
    "page": "Home",
    "title": "Goal",
    "category": "section",
    "text": "Psycho\'s primary goal is to fill the gap between Julia\'s output and the formatted result description of your manuscript, with the automated use of best practices guidelines, ensuring standardization and quality of results reporting. It also provides useful tools and functions for psychologists, neuropsychologists and neuroscientists for their everyday data analyses."
},

{
    "location": "index.html#Quick-Example-1",
    "page": "Home",
    "title": "Quick Example",
    "category": "section",
    "text": "using GLM, Psycho\n\n# Simulate some data\ndata = simulate_data_correlation([[0.3], [0.1]])\n\n# Standardize the results\nstandardize!(data)\n\n# Describe the data\nreport(data)The data contains 200 observations of the following variables:\n  - y (Mean = 0 ± 1.0 [-2.22, 2.6])\n  - Var1 (Mean = 0 ± 1.0 [-2.77, 3.19])\n  - Group (1HK, 50.0%; 2YP, 50.0%)using GLM\n\n# Fit a Linear Model\nmodel = lm(@formula(y ~ Var1 * Group), data)\n\n# Report the results\nresults = report(model)We fitted a linear regression to predict y with Var1 and Group (Formula: y ~ 1 + Var1 + Group + Var1 & Group).\nThe model\'s explanatory power (R²) is of 0.05 (adj. R² = 0.04). The model\'s intercept is at -0.0. Within this model:\n  - Var1 is significant (β = 0.3, t(196) = 3.05, 95% [0.11; 0.49], p < .01)\n  - Group: 2YP is not significant (β = 0.0, t(196) = 0.0, 95% [-0.27; 0.27], p > .1)\n  - Var1 & Group: 2YP is not significant (β = -0.2, t(196) = -1.44, 95% [-0.47; 0.07],\np > .1)"
},

{
    "location": "index.html#Content-1",
    "page": "Home",
    "title": "Content",
    "category": "section",
    "text": "Pages = [\n    \"man/tutorials.md\",\n    \"man/API.md\",\n    \"man/about.md\"\n]\nDepth = 2"
},

{
    "location": "man/API.html#",
    "page": "API",
    "title": "API",
    "category": "page",
    "text": ""
},

{
    "location": "man/API.html#API-1",
    "page": "API",
    "title": "API",
    "category": "section",
    "text": "Details about Psycho\'s functions.DocTestSetup = quote\n    using Psycho\nend"
},

{
    "location": "man/API.html#Report-1",
    "page": "API",
    "title": "Report",
    "category": "section",
    "text": ""
},

{
    "location": "man/API.html#Psycho.report-Tuple{DataFrame}",
    "page": "API",
    "title": "Psycho.report",
    "category": "method",
    "text": "report(df::DataFrames.DataFrame; kwargs...)\n\nDescribe the variables in a DataFrame.\n\nArguments\n\ndf: DataFrame.\nmissing_percentage::Bool: Show missings by percentage (default) or number.\nlevels_percentage::Bool: Show factor levels by percentage (default) or number.\nmedian::Bool::Bool: Show mean and sd (default) or median and mad.\ndispersion::Bool: Show dispersion (sd or mad).\nrange::Bool: Show range.\n\nnote: Note\nIdeas / help required:Add more indices (See #19)\nDeal with SubDataFrames (See #20)\n\nExamples\n\nreport(simulate_data_correlation([[0.1], [0.2]]))\n\n\n\n\n\n"
},

{
    "location": "man/API.html#Data-1",
    "page": "API",
    "title": "Data",
    "category": "section",
    "text": "report(df::DataFrames.DataFrame; kwargs...)"
},

{
    "location": "man/API.html#Psycho.report-Tuple{StatsModels.DataFrameRegressionModel{#s1,T} where T where #s1<:LinearModel}",
    "page": "API",
    "title": "Psycho.report",
    "category": "method",
    "text": "report(model::StatsModels.DataFrameRegressionModel{<:GLM.LinearModel}; CI::Number=95)\n\nDescribe a linear model.\n\nArguments\n\nmodel: A LinearModel.\nCI::Number: Confidence interval level.\n\nExamples\n\nusing GLM, DataFrames\n\nmodel = lm(@formula(y ~ Var1), DataFrame(y=[0, 1, 2, 3], Var1=[2, 3, 3.5, 4]))\nreport(model)\n\n\n\n\n\n"
},

{
    "location": "man/API.html#Psycho.report-Tuple{StatsModels.DataFrameRegressionModel{#s1,T} where T where #s1<:GeneralizedLinearModel}",
    "page": "API",
    "title": "Psycho.report",
    "category": "method",
    "text": "report(model::StatsModels.DataFrameRegressionModel{<:GLM.GeneralizedLinearModel}; CI::Number=95)\n\nDescribe a general linear model.\n\nArguments\n\nmodel: A GeneralizedLinearModel.\nCI::Number: Confidence interval level.\n\nExamples\n\nusing GLM, DataFrames\n\nmodel = glm(@formula(y ~ Var1), DataFrame(y=[0, 0, 1, 1], Var1=[1, 2, 2, 4]), GLM.Binomial())\nreport(model)\n\n\n\n\n\n"
},

{
    "location": "man/API.html#Models-1",
    "page": "API",
    "title": "Models",
    "category": "section",
    "text": "report(model::StatsModels.DataFrameRegressionModel{<:GLM.LinearModel}; CI=95)report(model::StatsModels.DataFrameRegressionModel{<:GLM.GeneralizedLinearModel}; CI=95)"
},

{
    "location": "man/API.html#Psycho.standardize",
    "page": "API",
    "title": "Psycho.standardize",
    "category": "function",
    "text": "standardize(X; robust::Bool=false)\n\nStandardize (scale and reduce, Z-score) X so that the variables are expressed in terms of standard deviation (i.e., mean = 0, SD = 1).\n\nArguments\n\nX: Array or DataFrame.\nrobust::Bool: If true, the standardization will be based on median and mad instead of mean and sd (default).\n\nnote: Note\nIdeas / help required:Deal with missing values (See #4)\n\nExamples\n\nstandardize([1, 2, 3])\n\n# output\n\n3-element Array{Float64,1}:\n -1.0\n  0.0\n  1.0\n\n\n\n\n\n"
},

{
    "location": "man/API.html#Psycho.perfectNormal",
    "page": "API",
    "title": "Psycho.perfectNormal",
    "category": "function",
    "text": "perfectNormal(n::Int, mean::Number=0, sd::Number=1)\n\nGenerate an almost-perfect normal distribution of size n.\n\nArguments\n\nn::Int: Length of the vector.\nmean::Number: Mean of the vector.\nsd::Number: SD of the vector.\n\nExamples\n\nperfectNormal(10, 0, 1)\n\n\n\n\n\n"
},

{
    "location": "man/API.html#Psycho.r2_tjur-Tuple{StatsModels.DataFrameRegressionModel{#s1,T} where T where #s1<:GeneralizedLinearModel}",
    "page": "API",
    "title": "Psycho.r2_tjur",
    "category": "method",
    "text": "r2_tjur(model::StatsModels.DataFrameRegressionModel{<:GLM.GeneralizedLinearModel})\n\nCompute Tjur\'s (2009) D (R²).\n\nThe Coefficients of Determination (D), also referred to as Tjur\'s R² (Tjur, 2009), is asymptotically equivalent to the classical version of R² for linear models.\n\nArguments\n\nmodel: A GeneralizedLinearModel.\n\nReferences\n\nTjur, T. (2009). Coefficients of determination in logistic regression models—A new proposal: The coefficient of discrimination. The American Statistician, 63(4), 366-372.\n\nExamples\n\nusing GLM, DataFrames\n\nmodel = glm(@formula(y ~ Var1), DataFrame(y=[0, 0, 1, 1], Var1=[1, 2, 2, 4]), GLM.Binomial())\nr2_tjur(model)\n\n# output\n0.5\n\n\n\n\n\n"
},

{
    "location": "man/API.html#Core-1",
    "page": "API",
    "title": "Core",
    "category": "section",
    "text": "standardizeperfectNormal(n::Int, mean::Number=0, sd::Number=1)r2_tjur(model::StatsModels.DataFrameRegressionModel{<:GLM.GeneralizedLinearModel})"
},

{
    "location": "man/API.html#Psycho.Rules",
    "page": "API",
    "title": "Psycho.Rules",
    "category": "type",
    "text": "Rules(breakpoints::AbstractVector, labels::AbstractVector, iflower::Bool=true)\n\nCreate a container for interpretation rules of thumb. See interpret(x::Real, rules::Rules).\n\nArguments\n\nbreakpoints::AbstractVector: Vector of value break points (edges defining categories).\nlabels::AbstractVector: Labels associated with each category. Must contain one label more than breakpoints.\niflower::Bool: If true, each label will be given if the value is lower than its breakpoint. The contrary if false.\n\nExamples\n\nRules([0.05], [\"significant\", \"not significant\"], true)\n\n# output\n\nRules{Float64}([0.05], [\"significant\", \"not significant\"], true)\n\n\n\n\n\n"
},

{
    "location": "man/API.html#Psycho.interpret-Tuple{Real,Rules}",
    "page": "API",
    "title": "Psycho.interpret",
    "category": "method",
    "text": "interpret(x::Real, rules::Rules)\n\nInterpret a value based on a set of rules of thumb.\n\nArguments\n\nx::Real: The value to interpret.\nrules::Rules: A Rules object.\n\nExamples\n\np_rules = Rules([0.05], [\"significant\", \"not significant\"], true)\ninterpret(0.04, p_rules)\n\n# output\n\n\"significant\"\n\n\n\n\n\n"
},

{
    "location": "man/API.html#Psycho.interpret_p-Tuple{Number}",
    "page": "API",
    "title": "Psycho.interpret_p",
    "category": "method",
    "text": "interpret_p(p::Number; alpha=::Number=0.05)\n\nInterpret the p value based on the alpha level.\n\nP-values are the probability of obtaining an effect at least as extreme as the one in your sample data, assuming the truth of the null hypothesis. The significance level, also denoted as alpha or α, is the probability of rejecting the null hypothesis when it is true (i.e., claiming \"there is an effect\" when there is not). For example, a significance level of 0.05 indicates a 5% risk of concluding that a difference exists when there is no actual difference. The traditional default for alpha is .05. However, a strong wave of criticism suggests to either justify your alpha (Lakens et al., 2018) or lower the treshold (for instance to .005; Benjamin et al., 2018).\n\nArguments\n\np::Number: The p value.\nalpha::Number: Significance treshold.\n\nExamples\n\ninterpret_p(0.04)\n\n# output\n\n\"significant\"\n\n\n\n\n\n"
},

{
    "location": "man/API.html#Psycho.format_p-Tuple{Number}",
    "page": "API",
    "title": "Psycho.format_p",
    "category": "method",
    "text": "format_p(p::Number; stars::Bool=false)\n\nFormat the p value according to APA standards.\n\nArguments\n\np::Number: The p value.\nstars::Bool: Add stars (*) when significant.\n\nExamples\n\nformat_p(0.04, stars=true)\n\n# output\n\n\"p < .05*\"\n\n\n\n\n\n"
},

{
    "location": "man/API.html#Interpret-1",
    "page": "API",
    "title": "Interpret",
    "category": "section",
    "text": "Rules(breakpoints::AbstractVector, labels::AbstractVector, iflower::Bool=true)interpret(x::Real, rules::Rules)interpret_p(p::Number; alpha::Number=0.05)format_p(p::Number; stars::Bool=false)"
},

{
    "location": "man/API.html#Simulate-1",
    "page": "API",
    "title": "Simulate",
    "category": "section",
    "text": ""
},

{
    "location": "man/API.html#Psycho.simulate_data_correlation",
    "page": "API",
    "title": "Psycho.simulate_data_correlation",
    "category": "function",
    "text": "simulate_data_correlation(coefs; n::Int=100, noise::Number=0.0, groupnames=:random)\n\nGenerate a DataFrame of correlated variables.\n\nMultiple Variables / Groups\n\nIf coefs is a vector (*e.g., [0.1, 0.2]), the DataFrame will contain length(coefs) variables (Var1, Var2, ...). Altough uncorrelated between them, they are  correlated to the outcome (y) by the specified coefs.\nIf coefs is a vector of vectors (e.g., [[0.1], [0.2]]), it will create length(coefs) groups, *i.e., stacked DataFrames with a correlation between the variables and the outcome varying between groups. It is possible to specify the groupnames.\n\nArguments\n\ncoefs: Correlation coefficients. Can be a number, a vector of numbers or a vector of vectors.\nn::Int: Number of observations.\nnoise::Number: The SD of the random gaussian noise.\ngroupnames::Vector: Vector of group names (default to :random).\nkwargs...: Arguments to pass to other functions.\n\nnote: Note\nIdeas / help required:Different group sizes (See #9)\nBug in some cases (e.g., simulate_data_correlation([0.2, 0.9, 0.5])) related to failure in Cholesky factorization (See #11)\n\nExamples\n\nsimulate_data_correlation(0.2)\n\n\n\n\n\n"
},

{
    "location": "man/API.html#Psycho.simulate_data_logistic",
    "page": "API",
    "title": "Psycho.simulate_data_logistic",
    "category": "function",
    "text": "simulate_data_logistic(coefs; n::Int=100, noise::Number=0.0, groupnames=:random)\n\nGenerate a DataFrame of variables related a binary dependent variable by specified regression coefs.\n\nwarning: Warning\nThis function, adapted from this thread, doesn\'t work as expected (See #27).\n\nMultiple Variables / Groups\n\nIf coefs is a vector (*e.g., [0.1, 0.2]), the DataFrame will contain length(coefs) variables (Var1, Var2, ...). Altough uncorrelated between them, they are  correlated to the outcome (y) by the specified coefs.\nIf coefs is a vector of vectors (e.g., [[0.1], [0.2]]), it will create length(coefs) groups, *i.e., stacked DataFrames with a correlation between the variables and the outcome varying between groups. It is possible to specify the groupnames.\n\nArguments\n\ncoefs: Regression coefficients. Can be a number, a vector of numbers or a vector of vectors.\nn::Int: Number of observations.\nnoise::Number: The SD of the random gaussian noise.\ngroupnames::Vector: Vector of group names (default to :random).\nkwargs...: Arguments to pass to other functions.\n\nnote: Note\nIdeas / help required:Different group sizes (See #9)\n\nExamples\n\nsimulate_data_logistic(0.2)\n\n\n\n\n\n"
},

{
    "location": "man/API.html#Data-2",
    "page": "API",
    "title": "Data",
    "category": "section",
    "text": "simulate_data_correlationsimulate_data_logistic"
},

{
    "location": "man/API.html#Psycho.sdt_indices-NTuple{4,Int64}",
    "page": "API",
    "title": "Psycho.sdt_indices",
    "category": "method",
    "text": "sdt_indices(hit::Int, fa::Int, miss::Int, cr::Int; adjusted::Bool=true)\n\nCompute Signal Detection Theory (SDT) indices (d\', beta, c, A\', B\'\').\n\nArguments\n\nhit: Number of hits.\nfa: Number of false alarms.\nmiss: Number of misses.\ncr: Number of correct rejections.\nadjusted::Bool: Use Hautus (1995) adjustments for extreme values.\n\nIndices\n\nReturns a Dict containing the following indices:\n\ndprime (d\'): Sensitivity (pronounced (\"dee-prime\"). Reflects the distance between the two distributions: signal, and signal+noise and corresponds to the Z value of the hit-rate minus that of the false-alarm rate.\nbeta: Bias (criterion). The value for beta is the ratio of the normal density functions at the criterion of the Z values used in the computation of d\'. This reflects an observer\'s bias to say \'yes\' or \'no\' with the unbiased observer having a value around 1.0. As the bias to say \'yes\' increases (liberal), resulting in a higher hit-rate and false-alarm-rate, beta approaches 0.0. As the bias to say \'no\' increases (conservative), resulting in a lower hit-rate and false-alarm rate, beta increases over 1.0 on an open-ended scale.\nc: Another index of bias. the number of standard deviations from the midpoint between these two distributions, i.e., a measure on a continuum from \"conservative\" to \"liberal\".\nc_relative (c\'): Scaled criterion location (c) relative to performance (d\'). Indeed, with easier discrimination tasks a more extreme criterion (as measured by c) would be needed to yield the same amount of bias.\naprime (A\'): Non-parametric estimate of discriminability. An A\' near 1.0 indicates good discriminability, while a value near 0.5 means chance performance.\nbpp (B\'\'): Also referred to as B\'\'D (pronounced \"b prime prime d\"). Non-parametric estimate of bias. A B\'\' equal to 0.0 indicates no bias, positive numbers represent conservative bias (i.e., a tendency to answer \'no\'), negative numbers represent liberal bias (i.e., a tendency to answer \'yes\'). The maximum absolute value is 1.0.\npr and br: Indices based on the Two-High Threshold Model (Feenan & Snodgrass, 1990). Pr is the discrimination measure (also sometimes called the corrected recognition score). Br is the bias measure; values greater than 0.5 indicate a liberal bias, values less than 0.5 indicate a conservative bias.\n\nNote that for d\' and beta, adjustement for extreme values are made by default following the recommandations of Hautus (1995).\n\nnote: Note\nIdeas / help required:Compute new indices (See #17)\n\nExamples\n\nsdt_indices(hit=6, fa=7, miss=8, cr=9)\n\nReferences\n\nMacmillan, N. A., & Creelman, C. D. (2005). Detection theory: A user\'s guide (2nd ed.). Hove, England: Psychology Press\nStanislaw, H., & Todorov, N. (1999). Calculation of signal detection theory measures. Behavior research methods, instruments, & computers, 31(1), 137-149.\nhttps://memory.psych.mun.ca/models/recognition/index.shtml\n\n\n\n\n\n"
},

{
    "location": "man/API.html#SDT-1",
    "page": "API",
    "title": "SDT",
    "category": "section",
    "text": "sdt_indices(hit::Int, fa::Int, miss::Int, cr::Int; adjusted::Bool=true)"
},

{
    "location": "man/API.html#Psycho.simulate_coefs_correlation",
    "page": "API",
    "title": "Psycho.simulate_coefs_correlation",
    "category": "function",
    "text": "simulate_coefs_correlation(coefs_mean::Number=0.1; coefs_sd::Number=0.1, n::Int=10)\n\nGenerate a vector of random correlation coefficients from a normal distribution.\n\nArguments\n\ncoefs_mean::Number: Mean of the normal distribution from which to get the coefs.\ncoefs_sd::Number: SD of the normal distribution.\nn::Int: Number of coefficients.\n\nExamples\n\nsimulate_coefs_correlation(0.5)\n\n\n\n\n\n"
},

{
    "location": "man/API.html#Psycho.simulate_groupnames-Tuple{Int64}",
    "page": "API",
    "title": "Psycho.simulate_groupnames",
    "category": "method",
    "text": "simulate_groupnames(n::Int; nchar::Int=2)\n\nCreate vector of random group names of length n containing nchar characters.\n\nArguments\n\nn::Int: Number of group names.\nnchar::Int: Number of random characters in the name.\n\nnote: Note\nIdeas / help required:Can be enhanced to make it more procedural and less random (See #8)\nimplement different types simulations (e.g., \"A, B... AA, AB...\") (See #8)\n\nExamples\n\nsimulate_groupnames(10)\n\n\n\n\n\n"
},

{
    "location": "man/API.html#Misc-1",
    "page": "API",
    "title": "Misc",
    "category": "section",
    "text": "simulate_coefs_correlation(coefs_mean::Number=0.1; coefs_sd::Number=0.1, n::Int=10)simulate_groupnames(n::Int; nchar::Int=2)"
},

{
    "location": "man/about.html#",
    "page": "About",
    "title": "About",
    "category": "page",
    "text": ""
},

{
    "location": "man/about.html#About-1",
    "page": "About",
    "title": "About",
    "category": "section",
    "text": ""
},

{
    "location": "man/about.html#People-1",
    "page": "About",
    "title": "People",
    "category": "section",
    "text": "Dominique Makowski"
},

{
    "location": "man/about.html#Support-1",
    "page": "About",
    "title": "Support",
    "category": "section",
    "text": "L\'École de Neuropsychologie, Paris, France."
},

{
    "location": "man/about.html#Credits-1",
    "page": "About",
    "title": "Credits",
    "category": "section",
    "text": "Psycho is a high-level package that would not exist without its many dependencies. Credits go to their authors."
},

{
    "location": "man/about.html#Featured-in-1",
    "page": "About",
    "title": "Featured in",
    "category": "section",
    "text": "Psycho.jl has been used in the following publications:Let us know!"
},

{
    "location": "man/tutorials.html#",
    "page": "Tutorials",
    "title": "Tutorials",
    "category": "page",
    "text": ""
},

{
    "location": "man/tutorials.html#Tutorials-1",
    "page": "Tutorials",
    "title": "Tutorials",
    "category": "section",
    "text": ""
},

{
    "location": "man/tutorials.html#Design-1",
    "page": "Tutorials",
    "title": "Design",
    "category": "section",
    "text": "The package is centered around one function, report(), which goal is to transform a Julia object into readable text. It also provides useful general and domain-specific functions to efficiently process psychological data."
},

{
    "location": "man/tutorials.html#Simulate-some-Data-1",
    "page": "Tutorials",
    "title": "Simulate some Data",
    "category": "section",
    "text": "Let\'s start by simulating some correlated data:using Psycho  # Import the Psycho package\n\n# Simulate some data wit ha specified correlation coefficient (0.3)\ndata = simulate_data_correlation(0.3)\n\n# Describe the data\nreport(data)The data contains 100 observations of the following variables:\n  - y (Mean = 0 ± 1.0 [-1.9, 2.58])\n  - Var1 (Mean = 0 ± 1.0 [-2.18, 3.01])note: Note\nThe results reported here and those in your console might be not be exactly the same. This is due to the random nature of some functions that generate different results at each run.As we can see, the report() function does work on DataFrames! We have successfully generated two numeric variables, y and Var1."
},

{
    "location": "man/tutorials.html#Fit-a-Linear-Regression-1",
    "page": "Tutorials",
    "title": "Fit a Linear Regression",
    "category": "section",
    "text": "using GLM  # Import the package for fitting GLMs\n\nmodel = lm(@formula(y ~ Var1), data)\nreport(model)We fitted a linear regression to predict y with Var1 (Formula: y ~ 1 + Var1). The model\'s explanatory power (R²) is of 0.09 (adj. R² = 0.08). The model\'s intercept is at -0.0. Within this model:\n  - Var1 is significant (β = 0.3, t(98) = 3.11, 95% [0.11; 0.49], p < .01)This returns the model\'s formula and a general index of the model\'s predictive performance (here, the normal and adjusted R²). Then, it also reports all the parameters (often, the \"effects\" in psychology) and their characteristics: the coefficient (β), the statistic (the t value), degrees of freedom, confidence interval and p value. In our example, the regression coefficient of Var1 is indeed the one that we specified (0.3): everything worked correctly."
},

{
    "location": "man/tutorials.html#Fit-a-Multiple-GLM-1",
    "page": "Tutorials",
    "title": "Fit a Multiple GLM",
    "category": "section",
    "text": "Let\'s fit a more complex model involving more variables and a binomial outcome (made of zeros and ones).# Simulate some data suited for logistic regression with multiple groups\ndata = simulate_data_logistic([[0.3, 0.5], [0.1, 0.3]])\n\n# Describe the data\nreport(data)The data contains 200 observations of the following variables:\n  - y (Mean = 0.72 ± 0.45 [0.0, 1.0])\n  - Var1 (Mean = 0 ± 1.01 [-2.37, 2.44])\n  - Var2 (Mean = 0.06 ± 0.95 [-2.11, 2.67])\n  - Group (1DS, 50.0%; 2QC, 50.0%)We generated a dataset with one outcome (0 and 1), two numeric variables (Var1 and Var2) and one factor (Group) with two levels. To fit a logistic model (a subtype of GLMs suited for binomial outcomes), we do as previously, but by writing glm instead of lm and adding an additional argument at the end to specify the Binomial nature of the model.model = glm(@formula(y ~ Var1 + Var2 * Group), data, Binomial())\nreport(model)We fitted a logistic regression to predict y with Var1, Var2 and Group (Formula: y ~ 1 + Var1 + Var2 + Group + Var2 & Group). The model\'s explanatory power (Tjur\'s R²) is of 0.0. The model\'s intercept is at 1.01. Within this model:\n  - Var1 is not significant (β = 0.06, z(195) = 0.36, 95% [-0.25; 0.36], p > .1)\n  - Var2 is not significant (β = 0.39, z(195) = 1.55, 95% [-0.1; 0.88], p > .1)\n  - Group: 2QC is not significant (β = -0.18, z(195) = -0.56, 95% [-0.8; 0.44], p > .1)\n  - Var2 & Group: 2QC is not significant (β = -0.08, z(195) = -0.24, 95% [-0.75; 0.59], p > .1WIP"
},

]}
