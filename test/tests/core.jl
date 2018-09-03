import DataFrames, Statistics

@test standardize([1, 2, 3]) == [-1.0, 0, 1]
@test standardize([1, 2, 3], robust=true) ≈ [-0.67, 0, 0.67] atol=0.01
@test standardize!([1, 2, 3]) == [-1.0, 0, 1]
@test standardize(DataFrames.DataFrame([[1, 2, 3]])) == DataFrames.DataFrame([[-1.0, 0, 1]])

@test Statistics.mean(perfectNormal()) ≈ 0 atol=0.01
@test Statistics.mean(perfectNormal(n = 50)) ≈ 0 atol=0.01
