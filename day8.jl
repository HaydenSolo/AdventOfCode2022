include("utils.jl")

lines = readinput()

trees = map(l -> parseint.(l), split.(lines, ""))

function visible(trees, startrow, startcol)
    row = startrow
    col = startcol
    while row <= length(trees)
        row == length(trees) && (return true)
        trees[startrow][startcol] <= trees[row+1][col] && break
        row += 1
    end
    row = startrow
    while row >= 1
        row == 1 && (return true)
        trees[startrow][startcol] <= trees[row-1][col] && break
        row -= 1
    end
    row = startrow
    while col <= length(trees)
        col == length(trees) && (return true)
        trees[startrow][startcol] <= trees[row][col+1] && break
        col += 1
    end
    col = startcol
    while col >= 1
        col == 1 && (return true)
        trees[startrow][startcol] <= trees[row][col-1] && break
        col -= 1
    end
    return false
end

function visible(trees)
    total = 0
    for row in 1:length(trees)
        for col in 1:length(trees)
            visible(trees, row, col) && (total += 1)
        end
    end
    return total
end

println(visible(trees))

function get_score(trees, startrow, startcol)
    row = startrow
    col = startcol
    total_score = 1
    mult = 0
    while row < length(trees)
        mult += 1
        trees[startrow][startcol] <= trees[row+1][col] && break
        row += 1
    end
    total_score *= mult
    row = startrow
    mult = 0
    while row > 1
        mult += 1
        trees[startrow][startcol] <= trees[row-1][col] && break
        row -= 1
    end

    total_score *= mult
    row = startrow
    mult = 0
    while col < length(trees)
        mult += 1
        trees[startrow][startcol] <= trees[row][col+1] && break
        col += 1
    end

    total_score *= mult
    col = startcol
    mult = 0
    while col > 1
        mult += 1
        trees[startrow][startcol] <= trees[row][col-1] && break
        col -= 1
    end
    total_score *= mult
    return total_score
end

function get_score(trees)
    best = 0
    for row in 1:length(trees)
        for col in 1:length(trees)
            get_score(trees, row, col) > best && (best = get_score(trees, row, col))
        end
    end
    return best
end

println(get_score(trees))