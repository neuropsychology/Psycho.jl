
sdt = sdt_indices(6, 7, 8, 9, adjusted=false)
@test sdt["dprime"] ≈ -0.023 atol=0.001
@test sdt["aprime"] ≈ 0.491 atol=0.001
@test sdt["beta"] ≈ 0.996 atol=0.001
@test sdt["c"] ≈ 0.169 atol=0.001
@test sdt["bpp"] ≈ 0.263 atol=0.001

sdt = sdt_indices.([9, 1], [1, 9], [1, 9], [9, 1], adjusted=false)
@test length(sdt) == 2
@test sdt[1]["aprime"] ≈ 0.944 atol=0.001
@test sdt[1]["pr"] ≈ 0.800 atol=0.001
@test sdt[1]["br"] ≈ 0.500 atol=0.001
@test sdt[1]["hit_rate"] ≈ 0.900 atol=0.001
@test sdt[1]["fa_rate"] ≈ 0.100 atol=0.001
