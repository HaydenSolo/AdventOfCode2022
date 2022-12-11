include("utils.jl")
lines = readinput()

abstract type Instruction end
struct Noop <: Instruction end
struct Addx <: Instruction
    add::Int
end

Instruction(line) = line == "noop" ? Noop() : Addx(parseint(split(line)[2]))

perform(instruction::Noop, current::Int) = current
perform(instruction::Addx, current::Int) = current + instruction.add

time(::Noop) = 1
time(::Addx) = 2

function doregister(lines)
    X = 1
    instructions = Instruction.(lines)
    nextrecord = 20
    cycle = 1
    records = Int[]
    for instruction in instructions
        if nextrecord == cycle || (instruction isa Addx && nextrecord -1 == cycle)
            push!(records, nextrecord*X)
            nextrecord += 40
        end
        X = perform(instruction, X)
        cycle += time(instruction)
        # println("$cycle, $X")
        # if nextrecord <= cycle
        #     # println("$cycle, $X")
        #     nextrecord += 40
        # end
    end
    sum(records)
end

doregister(lines)

pos(x) = (x-1) % 40

function docrt(lines)
    instructions = Instruction.(lines)
    X = 1
    currentinstruction = 1
    line = Char[]
    executing = false
    for cycle in 1:240
        drawing = pos(cycle)
        instruction = instructions[currentinstruction]
        push!(line, drawing in (X-1):(X+1) ? '#' : '.')
        if instruction isa Addx && !executing
            executing = true
        else
            executing = false
            X = perform(instruction, X)
            currentinstruction += 1
        end
        if drawing == 39
            println(String(line))
            line = Char[]
        end
    end
end

docrt(lines)