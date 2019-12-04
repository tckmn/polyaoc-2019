" run with ':sil so vim/04.vim' in an empty file
put =call('range', split(readfile('input')[0], '-'))
v/^0*1*2*3*4*5*6*7*8*9*$/d
redi@"
%s/\v(.)\1//n
%s/\v(.)\1\1+//g
%s/\v(.)\1//n
redi END
norm Vggpddj.j.
%norm wDx
