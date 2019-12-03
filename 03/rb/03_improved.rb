#!/usr/bin/env ruby

require 'set'

# input has 300 instructions of length <1000,
# so max coord is 300000
BASE = 600000

def path s
    pos = BASE/2
    pts = Set.new
    steps = {}
    sc = 0
    s.split(?,).each do |mov|
        n = mov[1..-1].to_i
        v = case mov[0]
            when ?U then BASE when ?D then -BASE
            when ?R then 1 when ?L then -1
            end
        (0..n).each do |i|
            pt = pos+v*i
            pts.add pt
            steps[pt] = sc+i unless steps.include? pt
        end
        pos += v*n; sc += n
    end
    [pts.delete(BASE/2), steps]
end

l1, l2 = File.readlines 'input'
p1, s1 = path l1
p2, s2 = path l2

# part 1
p (p1 & p2).map{|x| (x/BASE).abs + (x%BASE - BASE/2).abs}.min
# part 2
p (p1 & p2).map{|x| s1[x] + s2[x]}.min
