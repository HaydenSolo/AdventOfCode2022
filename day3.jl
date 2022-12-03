include("utils.jl")

function get_priority(c::Char)
    c >= 'a' && (return Int(c) - 96)
    return Int(c) - 38
end

function half(s)
    mid = Int(length(s)/2)
    first = s[1:mid]
    second = s[mid+1:end]
    return (first, second)
end

function groups(vec)
    all = Vector()
    total = length(vec)
    for i in 1:3:total
        push!(all, (vec[i], vec[i+1], vec[i+2]))
    end
    all
end

getchar(s) = s[1]

function get_same(bag::Tuple{Vector{Char}, Vector{Char}})
    first = bag[1]
    second = bag[2]
    for c in first
        c in second && (return c)
    end
end

function get_same(group::Tuple{Vector{Char}, Vector{Char}, Vector{Char}})
    first = group[1]
    second = group[2]
    third = group[3]
    for c in first
        c in second && c in third && (return c)
    end
end

lines = readinput()

chars = map(s -> getchar.(split(s, "")), lines)
compartments = half.(chars)
sames = get_same.(compartments)
priorities = get_priority.(sames)
println(sum(priorities))

all = groups(chars)
sames = get_same.(all)
priorities = get_priority.(sames)
println(sum(priorities))
