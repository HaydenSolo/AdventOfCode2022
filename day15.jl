include("utils.jl")
lines = readinput()

struct Pos
    x::Int
    y::Int
end

struct Sensor
    pos::Pos
    nearest::Pos
    distance::Int
end
smallest(s::Sensor) = min(s.nearest.x, s.pos.x)
biggest(s::Sensor) = max(s.nearest.x, s.pos.x)

distance(a::Pos, b::Pos) = abs(a.x - b.x) + abs(a.y - b.y)
distance(a::Pos, b::Sensor) = distance(a, b.pos)
distance(a::Sensor, b::Pos) = distance(a.pos, b)

function Sensor(line)
    vals = split(line, r"[,:=]")
    pos = Pos(parseint(vals[2]), parseint(vals[4]))
    nearest = Pos(parseint(vals[6]), parseint(vals[8]))
    Sensor(pos, nearest, distance(pos, nearest))
end

coveredby(pos::Pos, s::Sensor) = distance(pos, s) <= s.distance

function lineat(lines, y)
    sensors = Sensor.(lines)
    number = 0
    start = minimum(smallest.(sensors))
    endpoint = maximum(biggest.(sensors))
    range = endpoint - start
    for x in start-range:endpoint+range
        pos = Pos(x, y)
        any(coveredby(pos, sensor) for sensor in sensors) && (number += 1)
    end
    number - 1
end

println(lineat(lines, 2000000))

function checkall(sensors, pos)
    for sensor in sensors
        if coveredby(pos, sensor)
            return true
        end
    end
    return false
end

function getbeacon(lines, biggest)
    sensors = Sensor.(lines)
    for y in 0:biggest
        ranges = []
        for sensor in sensors
            width = sensor.distance - abs(sensor.pos.y - y)
            push!(ranges, (sensor.pos.x - width, sensor.pos.x + width))
        end
        sort!(ranges, by=a -> a[1])
        x = 0
        for (rangemin, rangemax) in ranges
            x > biggest && break
            rangemin > x && (return x * 4000000 + y)
            x = max(x, rangemax);
        end
    end
    return -1
end


println(getbeacon(lines, 4000000))