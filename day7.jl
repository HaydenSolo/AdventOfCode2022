include("utils.jl")

lines = readinput()

abstract type Structure end

struct Directory <: Structure
    name::AbstractString
    children::Vector{Structure}
    parent::Union{Directory, Nothing}
end
Directory(name::AbstractString) = Directory(name, Directory[], nothing)
Directory(name::AbstractString, parent::Directory) = Directory(name, Directory[], parent)

struct File <: Structure
    name::AbstractString
    size::Int
    parent::Union{Directory, Nothing}
end

name(s::Structure) = s.name

function get_folder_by_name(folder::Vector{Structure}, n::AbstractString)
    for f in folder
        name(f) == n && (return f)
    end
end

function make_dir(lines::Vector{String})
    root_dir = Directory(split(lines[1])[end])
    current_dir = root_dir
    for line in lines[2:end]
        spl = split(line)
        spl[2] == "ls" && continue
        spl[1] == "dir" && (push!(current_dir.children, Directory(spl[2], current_dir)); continue)
        if spl[2] == "cd"
            spl[3] == ".." && ((current_dir = current_dir.parent); continue)
            current_dir = get_folder_by_name(current_dir.children, spl[3])
            continue
        end
        push!(current_dir.children, File(spl[2], parseint(spl[1]), current_dir))
    end
    return root_dir
end

Base.size(x::Directory) = sum(size.(x.children))
Base.size(x::File) = x.size

function all_dir_below_size!(x::Directory, val::Int; list::Vector{Int}=Int[])
    this = size(x)
    this < val && push!(list, this)
    foreach(child -> all_dir_below_size!(child, val; list=list), x.children)
    return list
end

all_dir_below_size!(x::File, val::Int; list::Vector{Int}=Directory[]) = nothing

tree = make_dir(lines)
below = all_dir_below_size!(tree, 100000)

println(sum(below))

spaceused = 70000000 - size(tree)
spaceneeded = 30000000 - spaceused

function all_dir_above_size!(x::Directory, val::Int; list::Vector{Int}=Int[])
    this = size(x)
    this > val && push!(list, this)
    foreach(child -> all_dir_above_size!(child, val; list=list), x.children)
    return list
end

all_dir_above_size!(x::File, val::Int; list::Vector{Int}=Directory[]) = nothing

bigenough = all_dir_above_size!(tree, spaceneeded)

println(minimum(bigenough))