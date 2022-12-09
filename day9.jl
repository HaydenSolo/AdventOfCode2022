include("utils.jl")
lines = readinput()

struct Pos
    x::Int
    y::Int
end
maketypes(:R, :L, :U, :D)

get_direction(direction::AbstractString) = Dict("R"=>R,"L"=>L,"U"=>U, "D"=>D)[direction]()

moveto(start::Pos, direction::AbstractString) = moveto(start, get_direction(direction))
moveto(start::Pos, ::R) = Pos(start.x+1, start.y)
moveto(start::Pos, ::L) = Pos(start.x-1, start.y)
moveto(start::Pos, ::U) = Pos(start.x, start.y+1)
moveto(start::Pos, ::D) = Pos(start.x, start.y-1)

function follow(head::Pos, tail::Pos)
    abs(head.x - tail.x) <= 1 && abs(head.y - tail.y) <= 1 && (return tail)
    xmove = head.x == tail.x ? 0 : copysign(1, head.x - tail.x)
    ymove = head.y == tail.y ? 0 : copysign(1, head.y - tail.y)
    Pos(tail.x + xmove, tail.y + ymove)
end

function moveonlines(lines, knots)
    start = Pos(1, 1)
    visited = Pos[start]
    all = [start for _ in 1:knots]
    for line in lines
        dir, a = split(line)
        amount = parseint(a)
        for _ in 1:amount
            all[1] = moveto(all[1], dir)
            foreach(j -> (all[j] = follow(all[j-1], all[j])), 2:knots)
            push!(visited, all[end])
        end
    end
    unique(visited)
end

println(length(moveonlines(lines, 2)))
println(length(moveonlines(lines, 10)))