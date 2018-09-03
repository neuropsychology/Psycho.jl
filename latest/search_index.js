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
    "text": "Welcome to Psycho\'s for Julia documentation.note: Note\nThe package is not released yet."
},

{
    "location": "index.html#Status-and-News-1",
    "page": "Home",
    "title": "Status and News",
    "category": "section",
    "text": "2018/09/02: Initial release of the documentation."
},

{
    "location": "index.html#Content-1",
    "page": "Home",
    "title": "Content",
    "category": "section",
    "text": "Pages = [\n    \"man/API.md\"\n]\nDepth = 1"
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
    "text": "Details about Psycho\'s functions."
},

{
    "location": "man/API.html#Psycho.standardize",
    "page": "API",
    "title": "Psycho.standardize",
    "category": "function",
    "text": "standardize(X; robust::Bool=false)\n\nStandardize (scale and reduce, Z-score) X so that the variables are expressed in terms of standard deviation (i.e., mean = 0, SD = 1).\n\nArguments\n\nX: Array or DataFrame.\nrobust::Bool: If true, the standardization will be based on median and mad instead of mean and sd (default).\n\nnote: Note\nIdeas / help required:Deal with missing values (See #4)\n\nExamples\n\njulia> standardize([1, 2, 3])\n3-element Array{Float64,1}:\n -1.0\n  0.0\n  1.0\n\n\n\n\n\n"
},

{
    "location": "man/API.html#Core-1",
    "page": "API",
    "title": "Core",
    "category": "section",
    "text": "standardizeperfectNormal(n::Int=100, mean::Number=0, sd::Number=1)"
},

{
    "location": "man/API.html#Psycho.Rules",
    "page": "API",
    "title": "Psycho.Rules",
    "category": "type",
    "text": "Rules(breakpoints::AbstractVector, labels::AbstractVector, iflower::Bool=true)\n\nCreate a container for interpretation rules of thumb.\n\nSee interpret(x::Real, rules::Rules)\n\nArguments\n\nbreakpoints::AbstractVector: Vector of value break points (edges defining categories).\nlabels::AbstractVector: Labels associated with each category. Must contain one label more than breakpoints.\niflower::Bool: If true, each label will be given if the value is lower than its breakpoint. The contrary if false.\n\nExamples\n\njulia> Rules([0.05], [\"significant\", \"not significant\"], true)\nRules{Float64}([0.05], [\"significant\", \"not significant\"], true)\n\n\n\n\n\n"
},

{
    "location": "man/API.html#Psycho.interpret-Tuple{Real,Rules}",
    "page": "API",
    "title": "Psycho.interpret",
    "category": "method",
    "text": "interpret(x::Real, rules::Rules)\n\nInterpret a value based on a set of rules of thumb.\n\nArguments\n\nx::Real: The value to interpret.\nrules::Rules: A Rules object.\n\nExamples\n\njulia> p_rules = Rules([0.05], [\"significant\", \"not significant\"], true)\njulia> interpret(0.04, p_rules)\n\"signifcant\"\n\n\n\n\n\n"
},

{
    "location": "man/API.html#Psycho.interpret_p-Tuple{Number}",
    "page": "API",
    "title": "Psycho.interpret_p",
    "category": "method",
    "text": "interpret_p(p::Number; alpha=::Number=0.05)\n\nInterpret the p value based on the alpha level.\n\nP-values are the probability of obtaining an effect at least as extreme as the one in your sample data, assuming the truth of the null hypothesis. The significance level, also denoted as alpha or α, is the probability of rejecting the null hypothesis when it is true (i.e., claiming \"there is an effect\" when there is not). For example, a significance level of 0.05 indicates a 5% risk of concluding that a difference exists when there is no actual difference. The traditional default for alpha is .05. However, a strong wave of criticism suggests to either justify your alpha (Lakens et al., 2018) or lower the treshold (for instance to .005; Benjamin et al., 2018).\n\nArguments\n\np::Number: The p value.\nalpha::Number: Significance treshold.\n\nExamples\n\njulia> interpret_p(0.04)\n\"signifcant\"\n\n\n\n\n\n"
},

{
    "location": "man/API.html#Psycho.format_p-Tuple{Number}",
    "page": "API",
    "title": "Psycho.format_p",
    "category": "method",
    "text": "format_p(p::Number; stars::Bool=false)\n\nFormat the p value according to APA standards.\n\nArguments\n\np::Number: The p value.\nstars::Bool: Add stars (*) when significant.\n\nExamples\n\njulia> format_p(0.04)\n\"p < .05\"\n\njulia> format_p(0.04, stars=true)\n\"p < .05*\"\n\n\n\n\n\n"
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
    "text": "simulate_data_correlation(coefs; n::Int=100, noise::Number=0.0, groupnames=:random)\n\nGenerate a DataFrame of correlated variables.\n\nMultiple Variables / Groups\n\nIf coefs is a vector (*e.g., [0.1, 0.2]), the DataFrame will contain length(coefs) variables (Var1, Var2, ...). Altough uncorrelated between them, they are  correlated to the outcome (y) by the specified coefs.\nIf coefs is a vector of vectors (e.g., [[0.1], [0.2]]), it will create length(coefs) groups, *i.e., stacked DataFrames with a correlation between the variables and the outcome varying between groups. It is possible to specify the groupnames.\n\nArguments\n\ncoefs: Correlation coefficients. Can be a number, a vector of numbers or a vector of vectors.\nn::Int: Number of observations.\nnoise::Number: The SD of the random gaussian noise.\ngroupnames::Vector: Vector of group names (default to :random).\nkwargs...: Arguments to pass to other functions.\n\nnote: Note\nIdeas / help required:Different group sizes (See #9)\nBug in some cases (e.g., simulate_data_correlation([0.2, 0.9, 0.5])) related to failure in Cholesky factorization (See #11)\n\nExamples\n\njulia> simulate_data_correlation(0.2)\n100×2 DataFrames.DataFrame\n[...]\n\n\n\n\n\n"
},

{
    "location": "man/API.html#Data-1",
    "page": "API",
    "title": "Data",
    "category": "section",
    "text": "simulate_data_correlation"
},

{
    "location": "man/API.html#Psycho.sdt_indices-NTuple{4,Int64}",
    "page": "API",
    "title": "Psycho.sdt_indices",
    "category": "method",
    "text": "sdt_indices(hit::Int, fa::Int, miss::Int, cr::Int; adjusted::Bool=true)\n\nCompute Signal Detection Theory (SDT) indices (d\', beta, c, A\', B\'\').\n\nArguments\n\nhit: Number of hits.\nfa: Number of false alarms.\nmiss: Number of misses.\ncr: Number of correct rejections.\nadjusted::Bool: Use Hautus (1995) adjustments for extreme values.\n\nIndices\n\nReturns a Dict containing the following:\n\ndprime (d\'): Sensitivity. Reflects the distance between the two distributions: signal, and signal+noise and corresponds to the Z value of the hit-rate minus that of the false-alarm rate.\nbeta: Bias (criterion). The value for beta is the ratio of the normal density functions at the criterion of the Z values used in the computation of d\'. This reflects an observer\'s bias to say \'yes\' or \'no\' with the unbiased observer having a value around 1.0. As the bias to say \'yes\' increases (liberal), resulting in a higher hit-rate and false-alarm-rate, beta approaches 0.0. As the bias to say \'no\' increases (conservative), resulting in a lower hit-rate and false-alarm rate, beta increases over 1.0 on an open-ended scale.\naprime (A\'): Non-parametric estimate of discriminability. An A\' near 1.0 indicates good discriminability, while a value near 0.5 means chance performance.\nbpp (B\'\'): Non-parametric estimate of bias. A B\'\' equal to 0.0 indicates no bias, positive numbers represent conservative bias (i.e., a tendency to answer \'no\'), negative numbers represent liberal bias (i.e., a tendency to answer \'yes\'). The maximum absolute value is 1.0.\nc: Another index of bias. the number of standard deviations from the midpoint between these two distributions, i.e., a measure on a continuum from \"conservative\" to \"liberal\".\n\nNote that for d\' and beta, adjustement for extreme values are made by default following the recommandations of Hautus (1995).\n\nnote: Note\nIdeas / help required:Compute new indices (See #17)\n\nExamples\n\njulia> sdt_indices(hit=6, fa=7, miss=8, cr=9)\nDict{String,Float64} with 5 entries:\n  \"bpp\"    => -0.0711812\n  \"c\"      => 0.191778\n  \"aprime\" => 0.527793\n  \"dprime\" => -0.0235319\n  \"beta\"   => 0.995497\n\n\n\n\n\n"
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
    "text": "simulate_coefs_correlation(coefs_mean::Number=0.1; coefs_sd::Number=0.1, n::Int=10)\n\nGenerate a vector of random correlation coefficients from a normal distribution.\n\nArguments\n\ncoefs_mean::Number: Mean of the normal distribution from which to get the coefs.\ncoefs_sd::Number: SD of the normal distribution.\nn::Int: Number of coefficients.\n\nExamples\n\njulia> simulate_coefs_correlation(0.5)\n10-element Array{Array{Float64,1},1}:\n[...]\n\n\n\n\n\n"
},

{
    "location": "man/API.html#Psycho.simulate_groupnames-Tuple{Int64}",
    "page": "API",
    "title": "Psycho.simulate_groupnames",
    "category": "method",
    "text": "simulate_groupnames(n::Int; nchar::Int=2)\n\nCreate vector of random group names of length n containing nchar characters.\n\nArguments\n\nn::Int: Number of group names.\nnchar::Int: Number of random characters in the name.\n\nnote: Note\nIdeas / help required:Can be enhanced to make it more procedural and less random (See #8)\nimplement different types simulations (e.g., \"A, B... AA, AB...\") (See #8)\n\nExamples\n\njulia> simulate_groupnames(10)\n10-element Array{String,1}:\n[...]\n\n\n\n\n\n"
},

{
    "location": "man/API.html#Misc-1",
    "page": "API",
    "title": "Misc",
    "category": "section",
    "text": "simulate_coefs_correlation(coefs_mean::Number=0.1; coefs_sd::Number=0.1, n::Int=10)simulate_groupnames(n::Int; nchar::Int=2)"
},

]}
