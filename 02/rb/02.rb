#!/usr/bin/env ruby

@a = File.read('input').split(?,).map &:to_i
def run x, y
    a = @a.dup
    a[1] = x
    a[2] = y
    i = 0
    begin
        loop {
            case a[i]
            when 1 then a[a[i+3]] = a[a[i+1]] + a[a[i+2]]; i += 4
            when 2 then a[a[i+3]] = a[a[i+1]] * a[a[i+2]]; i += 4
            when 99 then return a[0]
            else return
            end
        }
    rescue NoMethodError, TypeError
        return
    end
end

# part 1
puts run 12, 2

# part 2
x, y = (r=*0..99).product(r).find{|x| run(*x) == 19690720}
puts 100*x + y
