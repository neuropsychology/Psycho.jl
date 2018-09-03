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
    if hit_rate > fa_rate
        a = 0.5 + ((hit_rate - fa_rate) * (1 + hit_rate - fa_rate) / (4 * hit_rate * (1 - fa_rate)))
    else
        a = 0.5 - ((fa_rate - hit_rate) * (1 + fa_rate - hit_rate) / (4 * fa_rate * (1 - hit_rate)))
    end

    return a
end

function sdt_bpp(hit_rate::Number, fa_rate::Number)
    if hit_rate > fa_rate
        bpp = (hit_rate*(1-hit_rate) - fa_rate*(1-fa_rate))/(hit_rate*(1-hit_rate) + fa_rate*(1-fa_rate))
    else
        bpp = (fa_rate*(1-fa_rate) - hit_rate*(1-hit_rate))/(fa_rate*(1-fa_rate) + hit_rate*(1-hit_rate))
    end

    return bpp
end






function sdt_indices(hit::Int, fa::Int; miss::Int, cr::Int, adjusted::Bool=true)

    # Parametric
    z_hit_rate, z_fa_rate = sdt_rates(hit, fa, miss=miss, cr=cr, adjusted=adjusted, z=true)
    dprime = sdt_dprime(z_hit_rate, z_fa_rate)
    beta = sdt_beta(z_hit_rate, z_fa_rate)
    c = sdt_c(z_hit_rate, z_fa_rate)

    # Non-parametric
    hit_rate, fa_rate = sdt_rates(hit, fa, miss=miss, cr=cr, adjusted=false, z=false)
    aprime = sdt_aprime(z_hit_rate, z_fa_rate)
    bpp = sdt_bpp(z_hit_rate, z_fa_rate)

    indices = Dict("dprime" => dprime,
                "aprime" => aprime,
                "beta" => beta,
                "c" => c,
                "bpp" => bpp)

    return indices
end




# #--- Variants
# # TODO
# # See https://cran.r-project.org/web/packages/psyphy/psyphy.pdf
#
# function sdt_dprime_mchoices(hit_rate::Number, m::Int)
#     # https://github.com/cran/psyphy/blob/master/R/dprime.mAFC.R
#     # https://cran.r-project.org/web/packages/psyphy/psyphy.pdf
# end
#
#
# #--- Meta
#
#
#
#
# #--- Tests
#
# import Random, Statistics
#
#
#
# hit = Random.rand(1:20)
# fa = Random.rand(1:20)
# miss = Random.rand(1:20)
# cr = Random.rand(1:20)
#
#
#
# results = Array{Float64}(0, 5)
# for i in 1:1000
#     results = vcat(results, sdt_test()')
# end
#
# Statistics.cor(results)
# # ---
#
#
# # bppd
#
# #---
#
# # meta-d'
#
# # http://sro.sussex.ac.uk/47633/1/BarrettDienesSeth_PSYCHMETH2013.pdf
# # http://psycnet.apa.org/fulltext/2016-60724-003.html#articleFootnotes_rev_124_1_91
# # Barrett, A. B., Dienes, Z., & Seth, A. K. (2013). Measures of metacognition on signal-detection theoretic models. Psychological methods, 18(4), 535.
# # https://github.com/smfleming/Self-evaluation-paper
# # https://github.com/metacoglab/HMeta-d/blob/master/fit_meta_d_mcmc.m
# # https://academic.oup.com/nc/article/2017/1/nix007/3748261
# # https://www.researchgate.net/publication/326195620_Quantifying_metacognitive_thresholds_using_signal-detection_theory
