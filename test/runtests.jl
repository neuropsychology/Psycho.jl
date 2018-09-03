using Test, Psycho

for file in readdir("tests/")
    include("tests/" * file)
end
