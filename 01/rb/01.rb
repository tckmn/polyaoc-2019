#!/usr/bin/env ruby

input = File.readlines('input').map &:to_i

# part 1
p input.map{|x| x/3-2 }.sum

# part 2
def f x; x > 0 ? x+f(x/3-2) : 0; end
p input.map{|x| f(x) - x }.sum
