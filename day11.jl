include("utils.jl")
lines = readinput()

mutable struct Monkey
    # id::Int
    values::Vector{Int}
    operation::Expr
    test::Int
    iftrue::Int
    iffalse::Int
    inspections::Int
end
getinspections(m::Monkey) = m.inspections
gettest(m::Monkey) = m.test

function makemonkey(lines, start)
    # id = parseint(lines[start][2])
    startingline = lines[start+1][19:end]
    values = parseint.(split(startingline, ", "))
    operation = Meta.parse(lines[start+2][20:end])
    test = parseint(lines[start+3][22:end])
    iftrue = parseint(lines[start+4][30:end])
    iffalse = parseint(lines[start+5][30:end])
    Monkey(values, operation, test, iftrue, iffalse, 0)
end

function makemonkeys(lines)
    monkeys = Monkey[]
    for id in 1:7:length(lines)
        monkey = makemonkey(lines, id)
        push!(monkeys, monkey)
    end
    monkeys
end

function evaluate(e::Expr, old::Int)
    eval(:(old = $old))
    eval(e)
end

function evalitem(m::Monkey, item::Int, combined::Int)
    m.inspections += 1
    new = evaluate(m.operation, item)
    # bored = div(new, 3)
    bored = new % combined 
    (bored, bored % m.test == 0 ? m.iftrue : m.iffalse)
end

function processmonkey(m::Monkey, ms::Vector{Monkey}, combined::Int)
    while length(m.values) != 0
        item = popfirst!(m.values)
        newval, to = evalitem(m, item, combined)
        push!(ms[to+1].values, newval)
    end
end


processmonkeys(ms::Vector{Monkey}) = foreach(m -> processmonkey(m, ms, prod(gettest.(ms))), ms)

function part1(lines)
    monkeys = makemonkeys(lines)
    for i in 1:10000
        processmonkeys(monkeys)
    end
    inspections = sort(getinspections.(monkeys))
    inspections[end] * inspections[end-1]
end

part1(lines)