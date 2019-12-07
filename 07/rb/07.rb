#!/usr/bin/env ruby

class IC
    attr_accessor :a, :i, :input, :dbg

    def initialize a, input=[]
        @a = Array === a ? a.dup : a.split(?,).map(&:to_i)
        @i = 0
        @input = Array === input ? input : [input]
        @dbg = true
    end

    def put a; Array === a ? @input.concat(a) : @input.push(a); end
    def run; a = []; while (o = self.get); a.push o; end; a; end
    def self.run a, input=[]; IC.new(a, input).run; end
    def self.get a, input=[]; IC.new(a, input).get; end

    def get
        begin
            loop {
                x = (@a[@i]/100)%10   == 0 ? @a[@a[@i+1]] : @a[@i+1] rescue nil
                y = (@a[@i]/1000)%10  == 0 ? @a[@a[@i+2]] : @a[@i+2] rescue nil
                z = (@a[@i]/10000)%10 == 0 ? @a[@a[@i+3]] : @a[@i+3] rescue nil
                case @a[@i] % 100
                when 1 then @a[@a[@i+3]] = x + y; @i += 4
                when 2 then @a[@a[@i+3]] = x * y; @i += 4
                when 3 then return puts 'inp' if @dbg && @input.empty?; @a[@a[@i+1]] = @input.shift; @i += 2
                when 4 then @i += 2; return x
                when 5 then x != 0 ? (@i = y) : (@i += 3)
                when 6 then x == 0 ? (@i = y) : (@i += 3)
                when 7 then @a[@a[@i+3]] = x <  y ? 1 : 0; @i += 4
                when 8 then @a[@a[@i+3]] = x == y ? 1 : 0; @i += 4
                when 99 then return nil
                else puts 'unk' if @dbg; return nil
                end
            }
        rescue NoMethodError, TypeError
            puts 'err' if @dbg
            return nil
        end
    end
end

code = File.read 'input'

# part 1
puts [*0..4].permutation(5).map{|x|
    op = 0
    x.each do |i|
        op = IC.get code, [i, op]
    end
    op
}.max

# part 2
puts [*5..9].permutation(5).map{|x|
    arr = x.map{|i| IC.new code, i}
    val = 0
    while val
        res = val
        arr.each do |i|
            i.put val
            val = i.get
        end
    end
    res
}.max
