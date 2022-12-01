mutable struct Elf
    calories::Int64
end
Elf() = Elf(0)
getcal(x::Elf) = x.calories

f = open("input.txt", "r")
lines = readlines(f)
elves = Elf[Elf()]

foreach(line -> (line == "" ? push!(elves, Elf()) : (elves[end].calories += parse(Int64, line))), lines)

highest = maximum(sort(getcal.(elves)))
println(highest)

highest = sum(sort(getcal.(elves))[end-2:end])
println(highest)

close(f)

