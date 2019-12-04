#!/usr/bin/env ruby

nums = Range.new *File.read('input').chomp.split(?-)
good = nums.filter{|i| i =~ /(.)\1/ && i.chars == i.chars.sort}

# part 1
p good.size

# part 2
p good.filter{|i| i.chars.chunk{|x|x}.any?{|_,x| x.size == 2}}.size
