struct Rules{T<:Real}
	breakpoints::AbstractVector{T}
	labels::AbstractVector
	labeliflower::Bool
end

function Rules(breakpoints::AbstractVector, labels::AbstractVector, labeliflower::Bool=true)
    if length(breakpoints) != length(labels)-1
        error("There must be exactly one more label than breakpoints.")
    elseif !issorted(breakpoints)
        error("Breakpoints must be sorted.")
    else
        Rules(breakpoints, labels, labeliflower)
    end
end
Rules(; breakpoints::AbstractVector, labels::AbstractVector, labeliflower::Bool=true) =
Rules(breakpoints, labels, labeliflower)


function interpret(x::Real, rules::Rules)
    rules.labels[1+searchsortedlast(rules.breakpoints, x, lt=(rules.labeliflower ? (<) : (<=)))]
end
interpret(;x::Real, rules::Rules) = interpret(x, rules)
