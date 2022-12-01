mutable struct Elf
    calories::Int64
end
Elf() = Elf(0)
getcal(x::Elf) = x.calories

f = open("input.txt", "r")
lines = readlines(f)
elves = Elf[Elf()]
for line in lines
    line == "" && push!(elves, Elf())
    line == "" || (elves[end].calories += parse(Int64, line))
end

highest = maximum(sort(getcal.(elves)))
println(highest)

highest = sum(sort(getcal.(elves))[end-2:end])
println(highest)

close(f)

