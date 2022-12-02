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


getme(::Rock) = 1
getme(::Paper) = 2
getme(::Scissors) = 3

score(::Rock, ::Rock) = 3
score(::Paper, ::Paper) = 3
score(::Scissors, ::Scissors) = 3

score(::Rock, ::Paper) = 6
score(::Rock, ::Scissors) = 0
score(::Paper, ::Rock) = 0
score(::Paper, ::Scissors) = 6
score(::Scissors, ::Paper) = 0
score(::Scissors, ::Rock) = 6


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