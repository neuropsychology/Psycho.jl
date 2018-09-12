using GLM, DataFrames



function sdt_glm(hit::Int, fa::Int; miss::Int, cr::Int)

    # Initialize empty vectors
    response = zeros(hit+fa+miss+cr)
    signal = zeros(hit+fa+miss+cr)

    # Add ones where needed
    response[1:hit] = repeat([1], hit)
    signal[1:hit] = repeat([1], hit)

    response[hit+1:hit+fa] = repeat([1], fa)

    signal[hit+fa+1:hit+fa+miss] = repeat([1], miss)

    # Transform to dataframe
    data = DataFrame(signal=signal, response=response)

    # Fit GLM
    model = glm(@formula(response ~ signal), data, Bernoulli(), ProbitLink())
    coefs = GLM.coef(model)

    # Extract coefs
    indices_glm = Dict("dprime_glm" => coefs[2],
                       "Xc_glm" => -1*coefs[1])
    return indices_glm
end
