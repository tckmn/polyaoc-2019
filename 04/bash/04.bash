#!/usr/bin/env bash

seq $(tr - ' ' <input) | grep '^0*1*2*3*4*5*6*7*8*9*$' > tmp
grep -c '\(.\)\1' tmp
sed 's/\(.\)\1\1\1*//g' tmp | grep -c '\(.\)\1'
rm tmp
