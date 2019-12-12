#!/usr/bin/env ruby

require 'set'

a = File.readlines('input').map{|x| [x.scan(/-?\d+/).map(&:to_i), [0,0,0]]}
seen = Array.new(3){Set.new}
pds = Array.new 3

(0..).each do |n|
    a = a.map{|p, v|
        new = v.zip(*a.map{|p2, _| p2.zip(p).map{|x,y|x<=>y}}).map &:sum
        [p.zip(new).map{|x,y|x+y}, new]
    }

    # part 1
    p a.map{|b| b.map{|c| c.map(&:abs).sum}.reduce :*}.sum if n == 999

    # part 2
    a.flatten(1).transpose.zip(seen, [0,1,2]) do |nums, set, i|
        unless pds[i]
            hsh = nums.hash
            if set.include? hsh
                pds[i] = n
                if pds.compact == pds
                    p pds.reduce :lcm
                    exit
                end
            end
            set.add hsh
        end
    end
end
