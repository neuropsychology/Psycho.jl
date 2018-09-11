import Random


"""
    simulate_groupnames(n::Int; nchar::Int=2)

Create vector of random group names of length `n` containing `nchar` characters.

# Arguments
- `n::Int`: Number of group names.
- `nchar::Int`: Number of random characters in the name.

!!! note

    **Ideas / help required:**
    - Can be enhanced to make it more procedural and less random (See [#8](https://github.com/neuropsychology/Psycho.jl/issues/8))
    - implement different types simulations (e.g., "A, B... AA, AB...") (See [#8](https://github.com/neuropsychology/Psycho.jl/issues/8))

# Examples
```julia
simulate_groupnames(10)
```
"""
function simulate_groupnames(n::Int; nchar::Int=2)

  groupnames = string.(collect(1:n))
  if nchar > 0
    id_char = sort!([Random.randstring(join('A':'Z'), nchar) for i = 1:n])
    groupnames = groupnames .* id_char
  end

  return groupnames
end









function simulate_data_groups(f; coefs::Vector{<:Vector}, groupnames=:random, n::Int=100, noise::Number=0.0, kwargs...)

  if groupnames == :random
    groupnames = simulate_groupnames(length(coefs); kwargs...)
  else
    # Sanity checks
    if !isa(groupnames, Vector)
      throw(ArgumentError("groupnames should be a Vector"))
    elseif length(groupnames) != length(coefs)
      throw(ArgumentError("groupnames should be of same size as coefs"))
    end
  end

  # Check and fix length difference
  if all(y -> y == first(length.(coefs)), length.(coefs)) == false
    longest = maximum(length.(coefs))
    for (i, groupcoefs) in enumerate(coefs)
      if length(groupcoefs) < longest
        coefs[i] = vcat(groupcoefs, fill(0.0, longest-length(groupcoefs)))
      end
    end
  end

  # Run by group
  data = DataFrames.DataFrame(Array{Float64}(undef, 0, length(coefs[1])+2))
  for (i, groupcoefs) in enumerate(coefs)
    group = f(groupcoefs, n=n, noise=noise)
    group[:Group] = groupnames[i]

    DataFrames.names!(data, names(group))
    data = vcat(data, group)
  end

  # Convert to categorical
  data[:Group] = DataFrames.categorical(data[:Group])

  return data
end
