
"""
    interpret_d(d::Number; rules::Union{String, Rules}="cohen1988")

Interpret a standardized difference (*Cohen's d*) with rules of thumb.

Cohen's *d* is a widely-used standardized effect size index. It's equivalent in many ways to a standardized regression coefficient, as both divide the size of the effect by the relevant standard deviations. Thus, instead of being in terms of the original units of X and Y, Cohen's *d* and standardized regression coefficients are expressed in terms of standard deviations.

# Arguments
- `d`: The *d* value.
- `rules`: Can be 'cohen1988', 'sawilowsky2009', or custom set of [Rules](@ref).

# Rules of thumb
- **Cohen (1988)**: The author suggests that *d* = 0.2 should be considered as small, *d* = 0.5 as medium, and *d* = 0.8 as large.
- **Sawilowsky (2009)**: The author suggests that values of 0.1, 0.2, 0.5, 0.8, 1.2 and 2.0 should be considered as very small, small, medium, large, very large and huge, respectively.

# Examples
```jldoctest
interpret_d(0.4, rules="cohen1988")

# output

"small"

# References
- Sawilowsky, S. S. (2009). New effect size rules of thumb.
- Cohen, J. (1988). Statistical power analysis for the behavioral sciences. 2nd.
```
"""
function interpret_d(d::Number; rules::Union{String, Rules}="cohen1988")

    if isa(rules, String)
        if rules == "cohen1988"
            rules = Rules(
                [0.2, 0.5, 0.8],
                ["very small", "small", "medium", "large"],
                true
                )
        elseif rules == "sawilowsky2009"
            rules = Rules(
                [0.1, 0.2, 0.5, 0.8, 1.2, 2.0],
                ["tiny", "very small", "small", "medium", "large", "very large", "huge"],
                true
                )
        else
            throw(ArgumentError("`rules` must be a String ('cohen1988', 'sawilowsky2009') or custom Rules."))
        end
    end

    interpretation = interpret(abs(d), rules)
    return interpretation
end
