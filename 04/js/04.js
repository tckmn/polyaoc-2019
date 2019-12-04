#!/usr/bin/env node

var fs = require('fs');
fs.readFile('input', 'utf-8', function(_, s) {
    let start, stop, part1 = part2 = 0;
    [start, stop] = s.split('-').map(x => +x);
    for (; start <= stop; ++start) {
        let chars = (''+start).split('');
        if (!chars.every((x, i) => !i || chars[i-1] <= x)) continue;
        part1 += /(.)\1/.test(start);
        part2 += /(.)\1/.test((''+start).replace(/(.)\1\1+/g, ''));
    }
    console.log(part1, part2);
});
