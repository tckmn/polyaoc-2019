#!/usr/bin/env ruby

def intcode a, input
    a = a.dup
    i = 0
    output = []
    begin
        loop {
            x = (a[i]/100)%10   == 0 ? a[a[i+1]] : a[i+1] rescue nil
            y = (a[i]/1000)%10  == 0 ? a[a[i+2]] : a[i+2] rescue nil
            z = (a[i]/10000)%10 == 0 ? a[a[i+3]] : a[i+3] rescue nil
            case a[i] % 100
            when 1 then a[a[i+3]] = x + y; i += 4
            when 2 then a[a[i+3]] = x * y; i += 4
            when 3 then a[a[i+1]] = input.shift; i += 2
            when 4 then output.push x; i += 2
            when 5 then x != 0 ? (i = y) : (i += 3)
            when 6 then x == 0 ? (i = y) : (i += 3)
            when 7 then a[a[i+3]] = x <  y ? 1 : 0; i += 4
            when 8 then a[a[i+3]] = x == y ? 1 : 0; i += 4
            when 99 then break
            else return nil
            end
        }
    rescue NoMethodError, TypeError
        return nil
    end
    output
end

code = File.read('input').split(?,).map &:to_i
p intcode code, [1]
p intcode code, [5]
