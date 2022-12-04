include("utils.jl")

lines = readinput()
ranges = map.(s -> parseint.(String.(s)), map(s -> (split.(s, "-")), split.(lines, ",")))

function Base.in(a::UnitRange{Int64}, b::UnitRange{Int64})
    for x in a
        x in b || (return false)
    end
    return true
end

function overlap(a::UnitRange{Int64}, b::UnitRange{Int64})
    for x in a
         x in b && (return true)
    end
    return false
end

units = map(s -> [s[1][1]:s[1][2], s[2][1]:s[2][2]], ranges)

number = 0
for unit in units
    (unit[1] in unit[2] || unit[2] in unit[1]) && (number += 1)
end
println(number)

number = 0
for unit in units
    overlap(unit[1], unit[2]) && (number += 1)
end
println(number)