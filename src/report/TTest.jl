import HypothesisTests


function model_parameters(model::HypothesisTests.OneSampleTTest)

    parameters = Dict("testname" => HypothesisTests.testname(model),
                "n" => model.n,
                "mean" => model.xbar,
                "stderr" => model.stderr,
                "df" => model.df,
                "u" => model.μ0,
                "statistic" => model.t,
                "CI" => HypothesisTests.confint(model),
                "p" => HypothesisTests.pvalue(model))
    return parameters
end
