#!/usr/bin/env ruby

class IC
    attr_accessor :a, :i, :base, :input, :dbg

    def initialize a, input=[]
        @a = Array === a ? a.dup : a.split(?,).map(&:to_i)
        @a = @a.map.with_index{|x,i| [i,x]}.to_h
        @a.default = 0
        @i = 0
        @base = 0
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
                xi = [@a[@i+1], @i+1, @base+@a[@i+1]][(@a[@i]/100)%10]   rescue nil
                yi = [@a[@i+2], @i+2, @base+@a[@i+2]][(@a[@i]/1000)%10]  rescue nil
                zi = [@a[@i+3], @i+3, @base+@a[@i+3]][(@a[@i]/10000)%10] rescue nil
                x, y, z = @a[xi], @a[yi], @a[zi]
                case @a[@i] % 100
                when 1 then @a[zi] = x + y; @i += 4
                when 2 then @a[zi] = x * y; @i += 4
                when 3 then return puts 'inp' if @dbg && @input.empty?; @a[xi] = @input.shift; @i += 2
                when 4 then @i += 2; return x
                when 5 then x != 0 ? (@i = y) : (@i += 3)
                when 6 then x == 0 ? (@i = y) : (@i += 3)
                when 7 then @a[zi] = x <  y ? 1 : 0; @i += 4
                when 8 then @a[zi] = x == y ? 1 : 0; @i += 4
                when 9 then @base += x; @i += 2
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
p IC.run code, 1
p IC.run code, 2
