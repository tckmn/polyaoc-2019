#!/usr/bin/env ruby

layers = *File.read('input').chomp.chars.each_slice(25*6)

# part 1
p layers.map{|x|[x.count(?0), x.count(?1)*x.count(?2)]}.min[1]

# part 2
puts Array.new(25) {|x|
    Array.new(6) {|y|
        layers.map{|z| z[y*25+x]}.join.delete(?2)[0].tr '01', ' #'
    }
}.transpose.map &:join
