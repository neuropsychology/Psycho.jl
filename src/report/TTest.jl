import HypothesisTests

function extract_parameters(x::HypothesisTests.OneSampleTTest)
    # Descriptive
    testname = HypothesisTests.testname(x)
    n = x.n
    mean = x.xbar
    stderr = x.stderr
    u = x.μ0
    df = x.df
    
    # Tests
    statistic = x.t
    CI = HypothesisTests.confint(x)
    p = HypothesisTests.pvalue(x)

    parameters = Dict("testname" => testname,
                "n" => n,
                "mean" => mean,
                "stderr" => stderr,
                "df" => df,
                "u" => u,
                "statistic" => statistic,
                "CI" => CI,
                "p" => p)
    return parameters
end


description = ""
describe(x)

x = HypothesisTests.OneSampleTTest(rand(10), 0)
x = HypothesisTests.OneSampleTTest(3, 1, 50, 0)

parameters = extract_parameters(x)
parameters["n"]


typeof(x)

confint(x)

methodswith(HypothesisTests.OneSampleTTest)
methodswith(HypothesisTests.HypothesisTest)

varinfo(HypothesisTests)



Matrix(x)
fieldnames(x)
