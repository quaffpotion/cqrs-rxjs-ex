let SessionLoad = 1
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/Documents/angular/cqrs-rxjs-ex
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +8 src/app/inner/inner.component.html
badd +5 src/app/inner/inner.component.ts
badd +8 src/app/app.component.html
badd +4 README.md
badd +1 ~/.vimrc
argglobal
%argdel
edit ~/.vimrc
set splitbelow splitright
wincmd _ | wincmd |
split
1wincmd k
wincmd w
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
wincmd t
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe '1resize ' . ((&lines * 23 + 25) / 51)
exe '2resize ' . ((&lines * 24 + 25) / 51)
exe 'vert 2resize ' . ((&columns * 141 + 105) / 211)
exe '3resize ' . ((&lines * 24 + 25) / 51)
exe 'vert 3resize ' . ((&columns * 69 + 105) / 211)
argglobal
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 253 - ((20 * winheight(0) + 11) / 23)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
253
normal! 019|
wincmd w
argglobal
if bufexists("src/app/inner/inner.component.html") | buffer src/app/inner/inner.component.html | else | edit src/app/inner/inner.component.html | endif
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 8 - ((7 * winheight(0) + 12) / 24)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
8
normal! 0
wincmd w
argglobal
if bufexists("src/app/inner/inner.component.ts") | buffer src/app/inner/inner.component.ts | else | edit src/app/inner/inner.component.ts | endif
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 5 - ((4 * winheight(0) + 12) / 24)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
5
normal! 03|
wincmd w
3wincmd w
exe '1resize ' . ((&lines * 23 + 25) / 51)
exe '2resize ' . ((&lines * 24 + 25) / 51)
exe 'vert 2resize ' . ((&columns * 141 + 105) / 211)
exe '3resize ' . ((&lines * 24 + 25) / 51)
exe 'vert 3resize ' . ((&columns * 69 + 105) / 211)
tabnext 1
if exists('s:wipebuf') && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 winminheight=1 winminwidth=1 shortmess=filnxtToOF
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
