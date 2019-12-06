#!/usr/bin/env julia

# input has 300 instructions of length <1000,
# so max coord is 300000
const BASE = Int64(600000)
const DIRS = Dict('U'=>BASE, 'D'=>-BASE, 'R'=>1, 'L'=>-1)

function path(s::String)
    pos = BASE÷2
    pts = Dict{Int64, Int32}()
    step = zero(Int32)

    for x = split(s, ",")
        dir, n = x[1], parse(Int32, x[2:end])
        for _ = 1:n
            pos += DIRS[dir]
            step += 1
            if !haskey(pts, pos); pts[pos] = step; end
        end
    end

    pts
end

d1, d2 = open("input") do f
    map(path, readlines(f))
end

pts = collect(keys(d1) ∩ keys(d2))
# part 1
println(minimum(map(x -> abs(fld(x, BASE)) + abs(mod(x, BASE) - BASE÷2), pts)))
# part 2
println(minimum(map(x -> d1[x] + d2[x], pts)))
