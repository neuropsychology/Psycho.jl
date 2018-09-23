"""
    interpret_odds(odds::Number; rules::Union{String, Rules}="chen2010", logodds::Bool=false)

Interpret odds ratio with rules of thumb.

The odds ratio (OR) is probably one of the most widely used index of effect size.


# Arguments
- `odds`: Odds ratio value.
- `rules`: Can be 'chen2010' or custom set of [Rules](@ref).
- `logodds`: Are these log odds ratio (*e.g.*, extracted from a logistic regression)?

# Rules of thumb
- **Chen et al., (2010)**: Thee authors demonstrate that OR = 1.68, 3.47, and 6.71 are equivalent to Cohen's d = 0.2 (small), 0.5 (medium), and 0.8 (large) and Cohen's d < 0.2 when OR < 1.5, and Cohen's d > 0.8 when OR > 5.


# Examples
```jldoctest
interpret_odds(2, rules="chen2010")

# output

"small"

# References
- Chen, H., Cohen, P., & Chen, S. (2010). How big is a big odds ratio? Interpreting the magnitudes of odds ratios in epidemiological studies. Communications in Statistics—Simulation and Computation, 39(4), 860-864.
```
"""
function interpret_odds(odds::Number; rules::Union{String, Rules}="chen2010", logodds::Bool=false)

    if logodds == true
        odds = exp(abs(odds))
    end

    if isa(rules, String)
        if rules == "chen2010"
            rules = Rules(
                [1.68, 3.47, 6.71],
                ["very small", "small", "medium", "large"],
                true
                )
        else
            throw(ArgumentError("`rules` must be a String ('chen2010') or custom Rules."))
        end
    end

    interpretation = interpret(abs(odds), rules)
    return interpretation
end
