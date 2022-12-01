parseint(s::String) = parse(Int64, s)
parsefloat(s::String) = parse(Float64, s)

parseint(ss) = parseint.(ss)
parsefloat(ss) = parsefloat.(ss)