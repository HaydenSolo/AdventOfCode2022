include("utils.jl")
lines = readinput()

function getpairs(lines)
    pairs = []
    for i in 1:3:length(lines)
        push!(pairs, (lines[i], lines[i+1]))
    end
    pairs
end


function compare(left::Int, right::Int)
    if left < right
        return true
    elseif right < left
        return false
    else
        return nothing
    end
end

function compare(left::Vector, right::Vector)
    i = 1
    for item in left
        i > length(right) && (return false)
        test = compare(left[i], right[i])
        test == true && (return true)
        test == false && (return false)
        i += 1
    end
    i <= length(right) && (return true)
    return nothing
end

compare(left::Int, right::Vector) = compare([left], right)
compare(left::Vector, right::Int) = compare(left, [right])


function makelists(linepairs)
    pairs = []
    for (i, line) in enumerate(linepairs)
        left = eval(Meta.parse(line[1]))
        right = eval(Meta.parse(line[2]))
        compare(left, right) && push!(pairs, i)
    end
    sum(pairs)
end

linepairs = getpairs(lines)
println(makelists(linepairs))

function getlines(lines)
    parsedlines = []
    for i in 1:3:length(lines)
        push!(parsedlines, lines[i])
        push!(parsedlines, lines[i+1])
    end
    push!(parsedlines, "[[2]]")
    push!(parsedlines, "[[6]]")
    parsedlines
end

function sortall(parsedlines)
    evallines = [eval(Meta.parse(line)) for line in parsedlines]
    sorted = sort(evallines; lt=compare)
    sorted
end

function getpos(sorted)
    two = findfirst(i -> i == [[2]], sorted)
    six = findfirst(i -> i == [[6]], sorted)
    two*six
end

parsedlines = getlines(lines)
sorted = sortall(parsedlines)
println(getpos(sorted))