using Test, Psycho

@test standardize([1, 2, 3]) == [-1.0, 0, 1]
@test standardize([1, 2, 3], robust=true) ≈ [-0.67, 0, 0.67] atol=0.01
