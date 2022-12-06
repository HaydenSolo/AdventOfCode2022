include("utils.jl")

lines = readinput()
list = split(lines[1], "")

function get_point(list, length)
    marker = list[1:length]
    index = length+1
    while marker != unique(marker)
        popfirst!(marker)
        push!(marker, list[index])
        index += 1
    end
    return index-1
end

println(get_point(list, 4))
println(get_point(list, 14))