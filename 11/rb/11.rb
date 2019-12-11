#!/usr/bin/env ruby

class IC
    attr_accessor :a, :i, :input, :dbg

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
                when 3 then return :need if @input.empty?; @a[xi] = @input.shift; @i += 2
                when 4 then @i += 2; return x
                when 5 then x != 0 ? (@i = y) : (@i += 3)
                when 6 then x == 0 ? (@i = y) : (@i += 3)
                when 7 then @a[zi] = x <  y ? 1 : 0; @i += 4
                when 8 then @a[zi] = x == y ? 1 : 0; @i += 4
                when 9 then @base += x; @i += 2
                when 99 then return :quit
                else puts 'unk' if @dbg; return nil
                end
            }
        rescue NoMethodError, TypeError
            puts 'err' if @dbg
            return nil
        end
    end
end

def go init
    panels = Hash.new 0
    panels[[0,0]] = init

    x,y = 0,0
    xv,yv = 0,1
    ic = IC.new File.read 'input'

    loop {
        case val = ic.get
        when :need then ic.put panels[[x,y]]
        when :quit then return panels
        else
            panels[[x,y]] = val
            case ic.get
            when 0 then xv,yv = -yv,xv
            when 1 then xv,yv = yv,-xv
            end
            x += xv
            y += yv
        end
    }
end

# part 1
p go(0).size

# part 2
panels = go 1
xr, yr = [0,1].map{|i| Range.new *panels.map{|k,v|k[i]}.minmax}
yr.reverse_each do |y|
    xr.each do |x|
        print ' #'[panels[[x,y]]]
    end
    puts
end
