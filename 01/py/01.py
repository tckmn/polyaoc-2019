#!/usr/bin/env python3

data = list(map(int, open('input').read().split()))

# part 1
print(sum(x//3-2 for x in data))

# part 2
f = lambda x: x+f(x//3-2) if x > 0 else 0
print(sum(f(x) - x for x in data))
