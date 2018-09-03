p_rules = Rules([0.05], ["significant", "not significant"], true)

@test interpret(0.04, p_rules) == "significant"
