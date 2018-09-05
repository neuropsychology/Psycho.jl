
"""
    interpret_p(p::Number; alpha=::Number=0.05)

Interpret the *p value* based on the `alpha` level.

P-values are the probability of obtaining an effect at least as extreme as the one in your sample data, assuming the truth of the null hypothesis. The significance level, also denoted as alpha or α, is the probability of rejecting the null hypothesis when it is true (*i.e.*, claiming "there is an effect" when there is not). For example, a significance level of 0.05 indicates a 5% risk of concluding that a difference exists when there is no actual difference. The traditional default for `alpha` is `.05`. However, a strong wave of criticism suggests to either **justify your alpha** ([Lakens et al., 2018](https://psyarxiv.com/9s3y6)) or lower the treshold (for instance to .005; [Benjamin et al., 2018](https://psyarxiv.com/mky9j/)).

# Arguments
- `p::Number`: The *p* value.
- `alpha::Number`: Significance treshold.

# Examples
```jldoctest
interpret_p(0.04)

# output

"signifcant"
```
"""
function interpret_p(p::Number; alpha::Number=0.05)

    rules = Rules(
        [alpha],
        ["significant", "not significant"],
        true
        )

    interpretation = interpret(p, rules)
    return interpretation
end


"""
    format_p(p::Number; stars::Bool=false)

Format the *p* value according to APA standards.

# Arguments
- `p::Number`: The *p* value.
- `stars::Bool`: Add stars (*) when significant.

# Examples
```jldoctest
format_p(0.04, stars=true)

# output

"p < .05*"
```
"""
function format_p(p::Number; stars::Bool=false)
    if p < .001
        output = "p < .001"
        if stars == true
            output *= "***"
        end
    elseif p < .01
        output = "p < .01"
        if stars == true
            output *= "**"
        end
    elseif p < 0.05
        output = "p < .05"
        if stars == true
            output *= "*"
        end
    elseif p > 0.1
        output = "p > .1"
    else
        output = replace("p = $(round(p, digits=2))", "0." => ".")
        if stars == true
            output *= "°"
        end
    end
    return output
end
