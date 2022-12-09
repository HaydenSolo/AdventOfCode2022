include("utils.jl")

lines = readinput()

struct Pos
    x::Int
    y::Int
end

function moveto(start::Pos, direction::AbstractString)
    direction == "R" && (return Pos(start.x+1, start.y))
    direction == "L" && (return Pos(start.x-1, start.y))
    direction == "U" && (return Pos(start.x, start.y+1))
    direction == "D" && (return Pos(start.x, start.y-1))
end

function follow(head::Pos, tail::Pos)
    head == tail && (return tail)
    abs(head.x - tail.x) <= 1 && abs(head.y - tail.y) <= 1 && (return tail)
    xmove = head.x == tail.x ? 0 : copysign(1, head.x - tail.x)
    ymove = head.y == tail.y ? 0 : copysign(1, head.y - tail.y)
    Pos(tail.x + xmove, tail.y + ymove)
end

function moveonlines(lines)
    start = Pos(1, 1)
    visited = Pos[start]
    head = start
    tail = start
    for line in lines
        dir, a = split(line)
        amount = parseint(a)
        for i in 1:amount
            head = moveto(head, dir)
            tail = follow(head, tail)
            push!(visited, tail)
        end
    end
    return unique(visited)
end

println(length(moveonlines(lines)))


function bigmoveonlines(lines, knots)
    start = Pos(1, 1)
    visited = Pos[start]
    all = [start for _ in 1:knots]
    for line in lines
        dir, a = split(line)
        amount = parseint(a)
        for i in 1:amount
            all[1] = moveto(all[1], dir)
            for j in 2:knots
                all[j] = follow(all[j-1], all[j])
            end
            push!(visited, all[end])
        end
    end
    return unique(visited)
end

println(length(bigmoveonlines(lines, 10)))