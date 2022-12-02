include("utils.jl")

struct Paper end
struct Rock end
struct Scissors end

struct Win end
struct Lose end
struct Draw end

function get_move(s)
    (s == "A") && return Rock()
    (s == "B") && return Paper()
    (s == "C") && return Scissors()
    (s == "X") && return Lose()
    (s == "Y") && return Draw()
    (s == "Z") && return Win()
end



get_move(::Rock, ::Win) = Paper()
get_move(::Rock, ::Lose) = Scissors()
get_move(::Rock, ::Draw) = Rock()

get_move(::Paper, ::Win) = Scissors()
get_move(::Paper, ::Lose) = Rock()
get_move(::Paper, ::Draw) = Paper()

get_move(::Scissors, ::Win) = Rock()
get_move(::Scissors, ::Lose) = Paper()
get_move(::Scissors, ::Draw) = Scissors()


getme(x::Rock) = 1
getme(x::Paper) = 2
getme(x::Scissors) = 3

score(x::Rock, y::Rock) = 3
score(x::Paper, y::Paper) = 3
score(x::Scissors, y::Scissors) = 3

score(x::Rock, y::Paper) = 6
score(x::Rock, y::Scissors) = 0
score(x::Paper, y::Rock) = 0
score(x::Paper, y::Scissors) = 6
score(x::Scissors, y::Paper) = 0
score(x::Scissors, y::Rock) = 6


function score(line)
    elf = line[1]
    result = line[2]
    me = get_move(elf, result)
    total = getme(me) + score(elf, me)
    return total
end

get_move(ss::Vector) = get_move.(ss)

moves = get_move.(split.(readinput()))

scores = score.(moves)

println(sum(scores))