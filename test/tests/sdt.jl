
sdt = sdt_indices(6, 7, 8, 9, adjusted=false)
@test sdt["dprime"] ≈ -0.023 atol=0.001
@test sdt["aprime"] ≈ 0.491 atol=0.001
@test sdt["beta"] ≈ 0.996 atol=0.001
@test sdt["c"] ≈ 0.169 atol=0.001
@test sdt["bpp"] ≈ 0.263 atol=0.001

sdt = sdt_indices(10, 1, 1, 10, adjusted=false)
@test sdt["aprime"] ≈ 0.950 atol=0.001
@test sdt["pr"] ≈ 0.818 atol=0.001
@test sdt["br"] ≈ 0.500 atol=0.001
