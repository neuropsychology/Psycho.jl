struct Rules{T<:Real}
	breakpoints::AbstractVector{T}
	labels::AbstractVector
	iflower::Bool
end


"""
    Rules(breakpoints::AbstractVector, labels::AbstractVector, iflower::Bool=true)

Create a container for interpretation rules of thumb. See [`interpret(x::Real, rules::Rules)`](@ref).

# Arguments
- `breakpoints::AbstractVector`: Vector of value break points (edges defining categories).
- `labels::AbstractVector`: Labels associated with each category. Must contain one label more than breakpoints.
- `iflower::Bool`: If true, each label will be given if the value *is lower* than its breakpoint. The contrary if false.

# Examples
```jldoctest
Rules([0.05], ["significant", "not significant"], true)

# output

Rules{Float64}([0.05], ["significant", "not significant"], true)
```
"""
function Rules(breakpoints::AbstractVector, labels::AbstractVector, iflower::Bool=true)
    if length(breakpoints) != length(labels)-1
        error("There must be exactly one more label than breakpoints.")
    elseif !issorted(breakpoints)
        error("Breakpoints must be sorted.")
    else
        Rules(breakpoints, labels, iflower)
    end
end
Rules(; breakpoints::AbstractVector, labels::AbstractVector, iflower::Bool=true) =
Rules(breakpoints, labels, iflower)





"""
    interpret(x::Real, rules::Rules)

Interpret a value based on a set of rules of thumb.

# Arguments
- `x::Real`: The value to interpret.
- `rules::Rules`: A [`Rules`](@ref) object.

# Examples
```jldoctest
p_rules = Rules([0.05], ["significant", "not significant"], true)
interpret(0.04, p_rules)

# output

"signifcant"
```
"""
function interpret(x::Real, rules::Rules)
    rules.labels[1+searchsortedlast(rules.breakpoints, x, lt=(rules.iflower ? (<) : (<=)))]
end
interpret(x::Real; rules::Rules) = interpret(x, rules)
