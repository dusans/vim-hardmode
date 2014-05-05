" hardmode.vim - Vim: HARD MODE!!!
" Authors:      Matt Parrott <parrott.matt@gmail.com>, Xeross <contact@xeross.me>
" Version:      1.0

if exists('g:HardMode_loaded')
    finish
endif
let g:HardMode_loaded = 1

if !exists('g:HardMode_currentMode')
    let g:HardMode_currentMode = 'easy'
end

if !exists('g:HardMode_level')
    let g:HardMode_level = 'advanced'
end

if !exists('g:HardMode_echo')
    let g:HardMode_echo = 1
end

if !exists('g:HardMode_hjklLimit')
    let g:HardMode_hjklLimit = 1
end

if !exists('g:HardMode_disable_arrows')
    let g:HardMode_disable_arrows = 1
end

if !exists('g:HardMode_hardmodeMsg')
    let g:HardMode_hardmodeMsg = "VIM: Hard Mode [ ':call EasyMode()' to exit ]"
end
if !exists('g:HardMode_easymodeMsg')
    let g:HardMode_easymodeMsg = "You are weak..."
end

" Only echo if g:HardMode_echo = 1
fun! HardModeEcho(message)
    if g:HardMode_echo
        echo a:message
    end
endfun

" Only allow HJKL once at a time
fun! HardModeHJKL(type)
  if !exists('g:HardMode_lastPos')
    let g:HardMode_lastPos = getpos('.')
  endif
  if !exists('g:HardMode_lastType')
    let g:HardMode_lastType = ''
  endif
  if !exists('g:HardMode_hjklCount')
    let g:HardMode_hjklCount = 0
  end

  if g:HardMode_lastType == a:type
    let g:HardMode_hjklCount += 1
  else
    let g:HardMode_hjklCount = 0
  end


  let [bufnum, lnum, col, off] = getpos('.')
  let col += off
  let diff = abs(g:HardMode_lastPos[1]-lnum)+abs(g:HardMode_lastPos[2]-col)
  let allowed = g:HardMode_lastPos[0]!=bufnum
              \  || diff!=1
              \  || v:count>1
              \  || g:HardMode_hjklCount < g:HardMode_hjklLimit
              \  || g:HardMode_lastType!=a:type

  if allowed
    let g:HardMode_lastPos = [bufnum, lnum, col, off]
    let g:HardMode_lastType = a:type
  endif

  return allowed ? a:type : "\<Esc>:call HardModeEcho(g:HardMode_hardmodeMsg)\<CR>"
endfun

fun! NoArrows()

    nnoremap <buffer> <Left> <Esc>:call HardModeEcho(g:HardMode_hardmodeMsg)<CR>
    nnoremap <buffer> <Right> <Esc>:call HardModeEcho(g:HardMode_hardmodeMsg)<CR>
    nnoremap <buffer> <Up> <Esc>:call HardModeEcho(g:HardMode_hardmodeMsg)<CR>
    nnoremap <buffer> <Down> <Esc>:call HardModeEcho(g:HardMode_hardmodeMsg)<CR>
    nnoremap <buffer> <PageUp> <Esc>:call HardModeEcho(g:HardMode_hardmodeMsg)<CR>
    nnoremap <buffer> <PageDown> <Esc>:call HardModeEcho(g:HardMode_hardmodeMsg)<CR>

    inoremap <buffer> <Left> <Esc>:call HardModeEcho(g:HardMode_hardmodeMsg)<CR>
    inoremap <buffer> <Right> <Esc>:call HardModeEcho(g:HardMode_hardmodeMsg)<CR>
    inoremap <buffer> <Up> <Esc>:call HardModeEcho(g:HardMode_hardmodeMsg)<CR>
    inoremap <buffer> <Down> <Esc>:call HardModeEcho(g:HardMode_hardmodeMsg)<CR>
    inoremap <buffer> <PageUp> <Esc>:call HardModeEcho(g:HardMode_hardmodeMsg)<CR>
    inoremap <buffer> <PageDown> <Esc>:call HardModeEcho(g:HardMode_hardmodeMsg)<CR>

    vnoremap <buffer> <Left> <Esc>:call HardModeEcho(g:HardMode_hardmodeMsg)<CR>
    vnoremap <buffer> <Right> <Esc>:call HardModeEcho(g:HardMode_hardmodeMsg)<CR>
    vnoremap <buffer> <Up> <Esc>:call HardModeEcho(g:HardMode_hardmodeMsg)<CR>
    vnoremap <buffer> <Down> <Esc>:call HardModeEcho(g:HardMode_hardmodeMsg)<CR>
    vnoremap <buffer> <PageUp> <Esc>:call HardModeEcho(g:HardMode_hardmodeMsg)<CR>
    vnoremap <buffer> <PageDown> <Esc>:call HardModeEcho(g:HardMode_hardmodeMsg)<CR>

endfun

fun! NoLetters()

    vnoremap <silent> <expr> <buffer> h HardModeHJKL('h')
    vnoremap <silent> <expr> <buffer> j HardModeHJKL('j')
    vnoremap <silent> <expr> <buffer> k HardModeHJKL('k')
    vnoremap <silent> <expr> <buffer> l HardModeHJKL('l')
    vnoremap <buffer> - <Esc>:call HardModeEcho(g:HardMode_hardmodeMsg)<CR>
    vnoremap <buffer> + <Esc>:call HardModeEcho(g:HardMode_hardmodeMsg)<CR>

    nnoremap <silent> <expr> <buffer> h HardModeHJKL('h')
    nnoremap <silent> <expr> <buffer> j HardModeHJKL('j')
    nnoremap <silent> <expr> <buffer> k HardModeHJKL('k')
    nnoremap <silent> <expr> <buffer> l HardModeHJKL('l')
    nnoremap <buffer> - <Esc>:call HardModeEcho(g:HardMode_hardmodeMsg)<CR>
    nnoremap <buffer> + <Esc>:call HardModeEcho(g:HardMode_hardmodeMsg)<CR>

endfun

fun! NoBackspace()
    set backspace=indent
endfun

fun! HardMode()

    if g:HardMode_disable_arrows
        call NoArrows()
    end

    if g:HardMode_level != 'wannabe'
        call NoLetters()
        call NoBackspace()
    end

    let g:HardMode_currentMode = 'hard'

    call HardModeEcho(g:HardMode_hardmodeMsg)
endfun

fun! EasyMode()
    set backspace=indent,eol,start

    silent! nunmap <buffer> <Left>
    silent! nunmap <buffer> <Right>
    silent! nunmap <buffer> <Up>
    silent! nunmap <buffer> <Down>
    silent! nunmap <buffer> <PageUp>
    silent! nunmap <buffer> <PageDown>

    silent! iunmap <buffer> <Left>
    silent! iunmap <buffer> <Right>
    silent! iunmap <buffer> <Up>
    silent! iunmap <buffer> <Down>
    silent! iunmap <buffer> <PageUp>
    silent! iunmap <buffer> <PageDown>

    silent! vunmap <buffer> <Left>
    silent! vunmap <buffer> <Right>
    silent! vunmap <buffer> <Up>
    silent! vunmap <buffer> <Down>
    silent! vunmap <buffer> <PageUp>
    silent! vunmap <buffer> <PageDown>

    silent! vunmap <buffer> h
    silent! vunmap <buffer> j
    silent! vunmap <buffer> k
    silent! vunmap <buffer> l
    silent! vunmap <buffer> -
    silent! vunmap <buffer> +

    silent! nunmap <buffer> h
    silent! nunmap <buffer> j
    silent! nunmap <buffer> k
    silent! nunmap <buffer> l
    silent! nunmap <buffer> -
    silent! nunmap <buffer> +

    let g:HardMode_currentMode = 'easy'

    call HardModeEcho(g:HardMode_easymodeMsg)
endfun

fun! ToggleHardMode()
    if g:HardMode_currentMode == 'hard'
        call EasyMode()
    else
        call HardMode()
    end
endfun
