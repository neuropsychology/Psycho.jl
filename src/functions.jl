"""
    f(x)

Add 2 to x.

This is a more extensive documentation.

See also: [`dupa`](@ref)

# Arguments
- `x::Number`: the number which to add 2.

# Examples
```jldoctest
julia> f(3)
5
```
"""
function f(x::Number)
    x+2
end





"""
    dupa(x)

Multiply x by 2.

This is a more extensive documentation.

See also: [`f`](@ref)

# Arguments
- `x::Number`: the number which to multiply by 2.

# Examples
```jldoctest
julia> dupa(3)
6
```
"""
function dupa(x::Number)
    x*2
end
