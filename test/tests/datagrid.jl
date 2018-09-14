using DataFrames, GLM

df = simulate_data_correlation([[0.2, 0.5], [0.4]])

@test nrow(datagrid(df, n=3)) == 54
@test nrow(datagrid(df, cols=["Var1", "Var2"], n=3)) == 9
@test nrow(datagrid(df, cols=[:Var1, :Var2], n=3)) == 9
@test nrow(datagrid(df, cols=[1, 2], n=3)) == 9
@test_throws ArgumentError datagrid(df, cols=[1.5, 2.2], n=3)
@test nrow(datagrid(df, cols=[1], n=3, fix_num=minimum)) == 3
@test nrow(datagrid(df, cols=[1], n=3, fix_num=3)) == 3
@test nrow(datagrid(df, cols=[1], n=3, fix_num=3, fix_fac=2)) == 3
@test length(datagrid([1, 3, missing])) == 10
@test length(datagrid(["dupa", "a", missing])) == 2

model = GLM.lm(GLM.@formula(y ~ Var1), df)

@test nrow(datagrid(model)) == 10
