include("utils.jl")

lines = readinput()

function get_init(lines)
    start = 0
    for line in lines
        line == "" && (return start)
        start += 1
    end
end

end_index = get_init(lines)
indexes = lines[end_index]
num_stacks = maximum(parseint.(split(indexes)))

function fill_stacks(num_stacks, end_index, lines)
    stacks = [[] for _ in 1:num_stacks]
    for level in (end_index-1):-1:1
       line = lines[level]
       for i in 2:4:(4*num_stacks)
            if line[i] != ' '
                index = Int(floor(i/4)+1)
                push!(stacks[index], line[i])
            end
       end
    end
    stacks
end

stacks = fill_stacks(num_stacks, end_index, lines)
first_instruction = end_index+2

function modify_stacks_p1!(stacks, instruction)
    instructions = split(instruction)
    amount, from, to = (parseint(instructions[2]), parseint(instructions[4]), parseint(instructions[6]))
    foreach(a -> push!(stacks[to], pop!(stacks[from])), 1:amount)
end

for instruction in lines[first_instruction:end]
    modify_stacks_p1!(stacks, instruction)
end

foreach(s -> print(s[end]), stacks)
println()


stacks = fill_stacks(num_stacks, end_index, lines)

function modify_stacks_p2!(stacks, instruction)
    instructions = split(instruction)
    amount, from, to = (parseint(instructions[2]), parseint(instructions[4]), parseint(instructions[6]))
    inbetween = []
    foreach(a -> push!(inbetween, pop!(stacks[from])), 1:amount)
    foreach(a -> push!(stacks[to], pop!(inbetween)), 1:amount)
end

for instruction in lines[first_instruction:end]
    modify_stacks_p2!(stacks, instruction)
end

foreach(s -> print(s[end]), stacks)
println()