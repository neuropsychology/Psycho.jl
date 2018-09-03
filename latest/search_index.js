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
    "text": "standardize"
},

{
    "location": "man/API.html#Simulate-1",
    "page": "API",
    "title": "Simulate",
    "category": "section",
    "text": ""
},

{
    "location": "man/API.html#Psycho.simulate_data_correlation-Tuple{Array{#s1,1} where #s1<:Number}",
    "page": "API",
    "title": "Psycho.simulate_data_correlation",
    "category": "method",
    "text": "simulate_data_correlation(coefs::Vector{<:Number}; n::Int=100, noise::Number=0.0)\n\nGenerate a DataFrame of correlated variables.\n\nArguments\n\ncoefs::Vector{<:Number}: Correlation coefficients.\nn::Int: Number of observations.\nnoise::Number: The SD of the random gaussian noise.\n\nnote: Note\nIdeas / help required:Different group sizes (See #9)\n\nExamples\n\njulia> simulate_data_correlation([0.2])\n100×2 DataFrames.DataFrame\n[...]\n\n\n\n\n\n"
},

{
    "location": "man/API.html#Data-1",
    "page": "API",
    "title": "Data",
    "category": "section",
    "text": "simulate_data_correlation(coefs::Vector{<:Number}; n::Int=100, noise::Number=0.0)"
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
