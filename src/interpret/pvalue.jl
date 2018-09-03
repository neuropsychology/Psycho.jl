
function interpret_p(p::Number)

    rules = Rules(
        [0.05],
        ["significant", "not significant"],
        true
        )

    interpretation = interpret(p, rules)
    return interpretation
end



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
        output = "p = $(round(p, digits=2))"
        if stars == true
            output *= "°"
        end
    end
    return output
end
