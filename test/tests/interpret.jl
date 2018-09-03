p_rules = Rules([0.05], ["significant", "not significant"], true)

@test interpret(0.04, p_rules) == "significant"

@test format_p(0.12, stars=true) == "p > .1"
@test format_p(0.06, stars=true) == "p = .06°"
@test format_p(0.04, stars=true) == "p < .05*"
@test format_p(0.005, stars=true) == "p < .01**"
@test format_p(0.0001, stars=true) == "p < .001***"
