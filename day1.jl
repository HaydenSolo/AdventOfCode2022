include("utils.jl")

mutable struct Elf
    calories::Int64
end
Elf() = Elf(0)
getcal(x::Elf) = x.calories

lines = readinput()
elves = Elf[Elf()]

foreach(line -> (line == "" ? push!(elves, Elf()) : (elves[end].calories += parseint(line))), lines)

highest = maximum(sort(getcal.(elves)))
println(highest)

highest = sum(sort(getcal.(elves))[end-2:end])
println(highest)