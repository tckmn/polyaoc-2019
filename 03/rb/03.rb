#!/usr/bin/env ruby

require 'set'

def path s
    x, y = 0, 0
    pts = Set.new
    steps = {}
    sc = 0
    s.split(?,).each do |mov|
        n = mov[1..-1].to_i
        xv, yv = case mov[0]
                 when ?U then [ 0,  1]
                 when ?D then [ 0, -1]
                 when ?R then [ 1,  0]
                 when ?L then [-1,  0]
                 end
        (0..n).each do |i|
            pt = [x+xv*i,y+yv*i]
            pts.add pt
            steps[pt] = sc+i unless steps.include? pt
        end
        x += xv*n; y += yv*n; sc += n
    end
    [pts.delete([0,0]), steps]
end

l1, l2 = File.readlines 'input'
p1, s1 = path l1
p2, s2 = path l2

# part 1
p (p1 & p2).map{|x| x.map(&:abs).sum}.min
# part 2
p (p1 & p2).map{|x| s1[x] + s2[x]}.min
