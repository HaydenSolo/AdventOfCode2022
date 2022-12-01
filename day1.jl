mutable struct Elf
    calories::Int64
end
Elf() = Elf(0)

f = open("input.txt", "r")
lines = readlines(f)
elves = Elf[]
push!(elves, Elf())
for line in lines
    line == "" && push!(elves, Elf())
    line == "" || (elves[end].calories += parse(Int64, line))
end

getcal(x::Elf) = x.calories

highest = maximum(getcal.(elves))

close(f)

