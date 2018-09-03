
sdt = sdt_indices(6, 7, 8, 9, adjusted=false)

@test sdt["dprime"] ≈ -0.023 atol=0.001
@test sdt["aprime"] ≈ 0.531 atol=0.001
@test sdt["beta"] ≈ 0.996 atol=0.001
@test sdt["c"] ≈ 0.169 atol=0.001
@test sdt["bpp"] ≈ -0.077 atol=0.001
