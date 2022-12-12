include("utils.jl")
lines = readinput()

gc(c) = c[1]

to_height(lines) = hcat(map(c -> gc.(c), split.(lines, ""))...)

height = to_height(lines)

struct Path
    sofar::Vector{CartesianIndex}
    location::CartesianIndex
end

function bfs(height, start, eend)
    indexes = findall(i -> true, height)
    paths = Path[Path([start], start)]
    visited = CartesianIndex[start]
    while !isempty(paths)
        newpaths = Path[]
        for path in paths
            location = path.location
            currentval = height[location]
            location == eend && (return path)
            currentval == 'S' && (currentval = 'a')
            possibilities = filter(i -> i in indexes, [location+CartesianIndex(1,0), location+CartesianIndex(-1,0), location+CartesianIndex(0,1), location+CartesianIndex(0,-1)])
            new = filter(i -> !(i in visited), possibilities)
            accessable = filter(i -> height[i] <= currentval + 1, new)
            for i in accessable
                push!(visited, i)
                newpath = deepcopy(path.sofar)
                push!(newpath, i)
                push!(newpaths, Path(newpath, i))
            end
        end
        paths = newpaths
    end
    return nothing
end

function dopath(height)
    start = findall(x -> x == 'S', height)[1]
    eend = findall(x -> x == 'E', height)[1]
    newheight = deepcopy(height)
    newheight[eend] = 'z'
    path = bfs(newheight, start, eend)
    path.sofar
end

function dopaths(height)
    starts = findall(x -> x == 'S' || x == 'a', height)
    eend = findall(x -> x == 'E', height)[1]
    newheight = deepcopy(height)
    newheight[eend] = 'z'
    paths = Path[]
    for start in starts
        path = bfs(newheight, start, eend)
        path !== nothing && push!(paths, path)
    end
    paths
end

println(minimum(map(p -> length(p.sofar), dopaths(height)))-1)