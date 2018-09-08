import Distributions



function sdt_rates(hit::Int, fa::Int; miss::Int, cr::Int, adjusted::Bool=true, z::Bool=false)

    targets = hit + miss
    distractors = fa + cr

    if adjusted == true
        hit_rate = (hit + 0.5) / ((hit + 0.5) + miss + 1)
        fa_rate = (fa + 0.5) / ((fa + 0.5) + cr + 1)
    else
        hit_rate = hit / targets
        fa_rate = fa / distractors
    end

    if z == true
        z_hit_rate = Distributions.quantile(Distributions.Normal(0, 1), hit_rate)
        z_fa_rate = Distributions.quantile(Distributions.Normal(0, 1), fa_rate)
        return z_hit_rate, z_fa_rate
    else
        return hit_rate, fa_rate
    end
end


function sdt_dprime(z_hit_rate::Number, z_fa_rate::Number)
    dprime = z_hit_rate - z_fa_rate
    return dprime
end


function sdt_beta(z_hit_rate::Number, z_fa_rate::Number)
    beta = exp(-z_hit_rate * z_hit_rate / 2 + z_fa_rate * z_fa_rate / 2)
    return beta
end

function sdt_c(z_hit_rate::Number, z_fa_rate::Number)
    c = -(z_hit_rate + z_fa_rate) / 2
    return c
end

function sdt_aprime(hit_rate::Number, fa_rate::Number)
    if hit_rate >= fa_rate
        a = 0.5 + ((hit_rate - fa_rate) * (1 + hit_rate - fa_rate) / (4 * hit_rate * (1 - fa_rate)))
    else
        a = 0.5 - ((fa_rate - hit_rate) * (1 + fa_rate - hit_rate) / (4 * fa_rate * (1 - hit_rate)))
    end

    return a
end

function sdt_bpp(hit_rate::Number, fa_rate::Number)
    if hit_rate >= fa_rate
        bpp = (hit_rate*(1-hit_rate) - fa_rate*(1-fa_rate))/(hit_rate*(1-hit_rate) + fa_rate*(1-fa_rate))
    else
        bpp = (fa_rate*(1-fa_rate) - hit_rate*(1-hit_rate))/(fa_rate*(1-fa_rate) + hit_rate*(1-hit_rate))
    end

    return bpp
end




"""
    sdt_indices(hit::Int, fa::Int, miss::Int, cr::Int; adjusted::Bool=true)

Compute Signal Detection Theory (SDT) indices (d', beta, c, A', B'').

# Arguments
- `hit`: Number of hits.
- `fa`: Number of false alarms.
- `miss`: Number of misses.
- `cr`: Number of correct rejections.
- `adjusted::Bool`: Use Hautus (1995) adjustments for extreme values.


# Indices
Returns a `Dict` containing the following:

- **dprime (d')**: Sensitivity. Reflects the distance between the two distributions: signal, and signal+noise and corresponds to the Z value of the hit-rate minus that of the false-alarm rate.
- **beta**: Bias (criterion). The value for beta is the ratio of the normal density functions at the criterion of the Z values used in the computation of d'. This reflects an observer's bias to say 'yes' or 'no' with the unbiased observer having a value around 1.0. As the bias to say 'yes' increases (liberal), resulting in a higher hit-rate and false-alarm-rate, beta approaches 0.0. As the bias to say 'no' increases (conservative), resulting in a lower hit-rate and false-alarm rate, beta increases over 1.0 on an open-ended scale.
- **aprime (A')**: Non-parametric estimate of discriminability. An A' near 1.0 indicates good discriminability, while a value near 0.5 means chance performance.
- **bpp (B'')**: Non-parametric estimate of bias. A B'' equal to 0.0 indicates no bias, positive numbers represent conservative bias (*i.e.*, a tendency to answer 'no'), negative numbers represent liberal bias (*i.e.*, a tendency to answer 'yes'). The maximum absolute value is 1.0.
- **c**: Another index of bias. the number of standard deviations from the midpoint between these two distributions, *i.e.*, a measure on a continuum from "conservative" to "liberal".

Note that for d' and beta, adjustement for extreme values are made by default following the recommandations of Hautus (1995).

!!! note

    **Ideas / help required:**
    - Compute new indices (See [#17](https://github.com/neuropsychology/Psycho.jl/issues/17))


# Examples
```jldoctest
sdt_indices(hit=6, fa=7, miss=8, cr=9)

# output

Dict{String,Float64} with 5 entries:
  "bpp"    => 0.00243546
  "c"      => 0.191778
  "aprime" => 0.490992
  "dprime" => -0.0235319
  "beta"   => 0.995497
```

# References

- Stanislaw, H., & Todorov, N. (1999). Calculation of signal detection theory measures. Behavior research methods, instruments, & computers, 31(1), 137-149.
"""
function sdt_indices(hit::Int, fa::Int, miss::Int, cr::Int; adjusted::Bool=true)

    # Parametric
    z_hit_rate, z_fa_rate = sdt_rates(hit, fa, miss=miss, cr=cr, adjusted=adjusted, z=true)
    dprime = sdt_dprime(z_hit_rate, z_fa_rate)
    beta = sdt_beta(z_hit_rate, z_fa_rate)
    c = sdt_c(z_hit_rate, z_fa_rate)

    # Non-parametric
    hit_rate, fa_rate = sdt_rates(hit, fa, miss=miss, cr=cr, adjusted=false, z=false)
    aprime = sdt_aprime(hit_rate, fa_rate)
    bpp = sdt_bpp(hit_rate, fa_rate)

    indices = Dict("dprime" => dprime,
                "aprime" => aprime,
                "beta" => beta,
                "c" => c,
                "bpp" => bpp)

    return indices
end
sdt_indices(; hit::Int, fa::Int, miss::Int, cr::Int, adjusted::Bool=true) = sdt_indices(hit, fa, miss, cr; adjusted=adjusted)
