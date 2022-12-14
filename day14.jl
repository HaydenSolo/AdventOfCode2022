include("utils.jl")
lines = readinput()

struct Point
    x::Int
    y::Int
end
function Point(s::AbstractString)
    all = parseint.(split(s, ","))
    Point(all[1], all[2])
end
gety(p::Point) = p.y

function makeline(line)
    points = Point.(split(line, " -> "))
    allpoints = Point[]
    for i in 1:(length(points)-1)
        start = points[i]
        endpoint = points[i+1]
        xdiff = start.x == endpoint.x ? 0 : copysign(1, endpoint.x - start.x)
        ydiff = start.y == endpoint.y ? 0 : copysign(1, endpoint.y - start.y)
        current = start
        push!(allpoints, start)
        while current != endpoint
            current = Point(current.x+xdiff, current.y+ydiff)
            push!(allpoints, current)
        end
    end
    unique(allpoints)
end

getpoints(lines) = unique(collect(Iterators.flatten(makeline.(lines))))

rocks = getpoints(lines)

function drop!(p::Point, points::Vector{Point}, deepest::Int, pt2=false)
    if pt2
        if p.y == deepest+1
            push!(points, p)
            return false
        end
    else
        p.y > deepest && (return false)
    end
    res = true
    if Point(p.x, p.y+1) ∉ points
        res = drop!(Point(p.x, p.y+1), points, deepest, pt2)
    elseif Point(p.x-1, p.y+1) ∉ points
        res = drop!(Point(p.x-1, p.y+1), points, deepest, pt2)
    elseif Point(p.x+1, p.y+1) ∉ points
        res = drop!(Point(p.x+1, p.y+1), points, deepest, pt2)
    else
        push!(points, p)
        res = true
    end
    res
end

function dropsand(rocks)
    points = copy(rocks)
    start = Point(500, 0)
    deepest = maximum(gety.(points))
    res = true
    count = 0
    while res
        count += 1
        res = drop!(start, points, deepest)
    end
    return count-1
end

println(dropsand(rocks))

function dropsandsafe(rocks)
    points = copy(rocks)
    start = Point(500, 0)
    deepest = maximum(gety.(points))
    count = 0
    while start ∉ points
        count += 1
        drop!(start, points, deepest, true)
    end
    return count
end

println(dropsandsafe(rocks))