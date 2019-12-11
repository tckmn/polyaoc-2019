#!/usr/bin/env ruby

a = File.read('input').lines.map{|x| x.chomp.chars}
ast = [*0...a.size].product([*0...a.size]).filter{|xx,yy| a[xx][yy] == ?#}
vis = ast.map{|x,y|
    ast.sort_by{|xx,yy| (xx-x)**2 + (yy-y)**2 }
      .group_by{|xx,yy| -Math.atan2(yy-y, xx-x) }
}
best = vis.max_by &:size

# part 1
p best.size

# part 2
x, y = best.sort_by{|k,v| k}[199][1][0]
p y*100+x
