#!/usr/bin/env ruby

require 'set'

orbits = File.readlines('input').map{|x| x.chomp.split ?) }
h1, h2 = Array.new(2) { Hash.new{|h,k| h[k] = [] }}
orbits.each do |a,b|
    h1[a].push b
    h2[a].push b
    h2[b].push a
end

# part 1
n = ->a{ h1[a].size + h1[a].map{|x| n[x]}.sum }
p orbits.flatten.uniq.map{|x| n[x]}.sum

# part 2
s = Set.new [h2['YOU'][0]]
(1..).each do |n|
    [*s].each do |x| h2[x].each do |y| s.add y; end; end
    p(n) && exit if s.include? h2['SAN'][0]
end
