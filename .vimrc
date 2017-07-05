" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" xwisen <1031649164@qq.com>
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" common setting 通用设置
" 是否使用vim扩展功能(相对vi)
" nocompatible 为使用,compatible为不使用
set nocompatible
" detection:ON
" plugin:ON
" indent:ON	
filetype off
" 设置鼠标模式
" 可设置模式有:
" n Normal mode
" v Visual mode
" i Insert mode
" c Command-line mode
" h all previous modes when editing a help file
" a all previous modes
" r for |hit-enter| and |more-prompt| prompt
set mouse=v
set ignorecase "是否忽略大小写设置
set autoread "自动刷新保存文件
set tags=tags; "自动向父目录找tag
set nu "显示行号
set ts=8 "设置tab键为8个空格
set autochdir
set encoding=utf-8
set cursorcolumn
set cursorline
set showmatch
set ignorecase "搜索时忽略大小写
set hlsearch "高亮显示结果
set backspace=indent,eol,start " the backspace can't delete
set foldmethod=indent " Enable folding
set foldlevel=99
" set status without powerline
set laststatus=2      " 总是显示状态栏"
highlight StatusLine cterm=bold ctermfg=yellow ctermbg=blue
set statusline=[%F]%y%r%m%*%=[Line:%l/%L,Column:%c][%p%%] "显示文件名：总行数，总的字符数
set ruler "在编辑过程中，在右下角显示光标位置的状态行"
let mapleader=','

nnoremap <space> za
" split navigations 界面跳转
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"SET Last Modified Time START
autocmd FileWritePre,BufWritePre *.go ks|call DataInsert() |'s
func DataInsert()
	call cursor(9,1)
	if search ('Last Modified') != 0
		let line = line('.')
		call setline(line, '// Last Modified: '.strftime("%Y-%m-%d %H:%M:%S"))
	endif
endfunc
" SET Last Modified Time END

" Uncomment the following to have Vim jump to the last position when reopening a file
au BufReadPost * '"

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
" All of your Plugins must be added before the following line

" vim plugin manager
Plugin 'gmarik/Vundle.vim'

" code complete
Plugin 'Valloric/YouCompleteMe'

" vim code color
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'

" file tree
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
" NERDTree config
" let NERDTreeWinPos="right"
let NERDTreeShowBookmarks=1
" let NERDTreeWinSize=30
map <F2> :NERDTreeToggle<CR>
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType")&&b:NERDTreeType == "primary") | q | endif
if has("autocmd")
	autocmd vimenter *.go NERDTree | set modifiable | set write
        " autocmd vimenter *.go <C-W><left>
endif

" comment and F4 自动注释
Plugin 'scrooloose/nerdcommenter'
map <F4> <leader>ci <CR>
" 注释的时候自动加个空格, 强迫症必配
let g:NERDSpaceDelims=1

" git support
" Plugin 'tpope/vim-fugitive'

" super search
Plugin 'kien/ctrlp.vim'

" status
" Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}

" tagbar to gotags(ctags)
" * 全部打开
" = 全部关闭
" o 打开/关闭
" s 排序
Plugin 'Tagbar'
nmap <F12> :TagbarToggle<CR>

" auto-pairs
Plugin 'jiangmiao/auto-pairs'
" Plugin 'Raimondi/delimitMate'

" golang plugin
Plugin 'fatih/vim-go'

" python.vim
" Plugin 'python.vim'

" python check pep8
Plugin 'nvie/vim-flake8'

" python autopep8
Plugin 'tell-k/vim-autopep8'

" python auto complete
" Plugin 'Pydiction'

" python mode
" Plugin 'klen/Python-mode'

" code fold python 代码折叠
Plugin 'tmhedberg/SimpylFold'
let g:SimpylFold_docstring_preview=1

" indentLine 代码缩进标识
" Plugin 'Yggdroot/indentLine'
" 缩进指示线"
" let g:indentLine_char='┆'
" let g:indentLine_enabled = 1

call vundle#end()            " required
filetype plugin indent on    " required
" 高亮及配色配置
" 默认配色 molokai
" F5切换至solarized
if has("syntax")
	  syntax on
	  syntax enable
endif
if has('gui_running') " vim code color
	set background=dark
        colorscheme solarized
else
        " colorscheme zenburn
        colorscheme molokai
 	"let g:molokai_original = 1
        " if vim is working without gui the t_Co must be set
        set t_Co=256
endif
call togglebg#map("<F5>") " solarized 底色转换

" go语言的tagbar配置
" 1.install gotags 'go get -u github.com/jstemmer/gotags'
" 2.make sure  in you shell PATH, you can call check it with /root/gopath/bin/gotags for gotags. work with tagbar
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }
let g:tagbar_autofocus = 1

" python 配置块
highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
let python_highlight_all=1
au BufNewFile,BufRead *.py set tabstop=4 |
           \set softtabstop=4 |
           \set shiftwidth=4 |
           \set textwidth=79 |
           \set expandtab |
           \set autoindent |
           \set fileformat=unix

" 支持virtualenv环境
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

" let g:pydiction_location='.vim/bundle/Pydiction/complete-dict'

" Python-mode
" Activate rope
" Keys:
" K             Show python docs
" <Ctrl-Space>  Rope autocomplete
" <Ctrl-c>g     Rope goto definition
" <Ctrl-c>d     Rope show documentation
" <Ctrl-c>f     Rope find occurrences
" <Leader>b     Set, unset breakpoint (g:pymode_breakpoint enabled)
" [[            Jump on previous class or function (normal, visual, operator modes)
" ]]            Jump on next class or function (normal, visual, operator modes)
" [M            Jump on previous class or method (normal, visual, operator modes)
" ]M            Jump on next class or method (normal, visual, operator modes)
" let g:pymode_rope = 1

" Documentation
" let g:pymode_doc = 1
" let g:pymode_doc_key = 'K'

" Linting
" let g:pymode_lint = 1
" let g:pymode_lint_checker = "pyflakes,pep8"
" Auto check on save
" let g:pymode_lint_write = 1

" Support virtualenv
" let g:pymode_virtualenv = 1

" Enable breakpoints plugin
" let g:pymode_breakpoint = 1
" let g:pymode_breakpoint_bind = '<leader>b'

" syntax highlighting
" let g:pymode_syntax = 1
" let g:pymode_syntax_all = 1
" let g:pymode_syntax_indent_errors = g:pymode_syntax_all
" let g:pymode_syntax_space_errors = g:pymode_syntax_all

" Don't autofold code
" let g:pymode_folding = 0

" go to definition
" let g:pymode_rope_goto_definition_bind = 'gd'


" autopep8设置"
let g:autopep8_disable_show_diff=1
" 按F5运行python"
map <F8> :Autopep8<CR>
map <F5> :Autopep8<CR> :w<CR> :call RunPython()<CR>
function RunPython()
	let mp = &makeprg
	let ef = &errorformat
        let exeFile = expand("%:t")
        setlocal makeprg=python\ -u
        set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
        silent make %
        copen
        let &makeprg = mp
        let &errorformat = ef
endfunction

" PEP8 代码风格检查
autocmd BufWritePost *.py call Flake8()

" ################### 自动补全 ###################
" 重启 :YcmRestartServer
" youcompleteme  默认tab  s-tab 和自动补全冲突
" let g:ycm_key_list_select_completion=['<c-n>']
" let g:ycm_key_list_select_completion = ['<Down>']
" let g:ycm_key_list_previous_completion=['<c-p>']
" let g:ycm_key_list_previous_completion = ['<Up>']
let g:ycm_key_invoke_completion = '<C-Space>'
let g:ycm_confirm_extra_conf=0 "关闭加载.ycm_extra_conf.py提示
let g:ycm_complete_in_comments = 1 "在注释输入中也能补全
let g:ycm_complete_in_strings = 1 "在字符串输入中也能补全
let g:ycm_collect_identifiers_from_tags_files=1 "开启 YCM 基于标签引擎
let g:ycm_collect_identifiers_from_comments_and_strings = 1 "注释和字符串中的文字也会被收入补全
let g:ycm_seed_identifiers_with_syntax=1 "语言关键字补全, 不过python关键字都很短，所以，需要的自己打开
let g:ycm_min_num_of_chars_for_completion=0 " 从第2个键入字符就开始罗列匹配项
" UltiSnips setting
let g:ycm_use_ultisnips_completer = 1 "提示UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" 跳转
" nnoremap <leader>jd :YcmCompleter GoToDefinition<CR>
" nnoremap <leader>gd :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
let g:ycm_goto_buffer_command = 'vertical-split' "[ 'same-buffer', 'horizontal-split', 'vertical-split', 'new-tab'  ]
let g:ycm_autoclose_preview_window_after_completion=1
" 黑名单,不启用
let g:ycm_filetype_blacklist = {
	\ 'tagbar' : 1,
	\ 'gitcommit' : 1,
	\}
" 引入，可以补全系统，以及python的第三方包 针对新老版本YCM做了兼容
" old version
if !empty(glob("~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py"))
    let g:ycm_global_ycm_extra_conf = "~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py"
endif
" new version
if !empty(glob("~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"))
   let g:ycm_global_ycm_extra_conf = "~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"
endif

" SET Comment START
autocmd BufNewFile *.go,*.py,*.sh exec ":call SetComment()" |normal 10Go
map <F3> :call SetComment()<CR>:10<CR>o
func SetComment()
	if expand("%:e") == 'go'
		call setline(1, "// GOLANG ")
		call append(1, '//***********************************************')
		call append(2, '//')
		call append(3, '//      Filename: '.expand("%"))
		call append(4, '//')
		call append(5, '//        Author: xwisen 1031649164@qq.com')
		call append(6, '//   Description: ---')
		call append(7, '//        Create: '.strftime("%Y-%m-%d %H:%M:%S"))
		call append(8, '// Last Modified: '.strftime("%Y-%m-%d %H:%M:%S"))
		call append(9, '//***********************************************')
		call append(10, '')
	elseif expand("%:e") == 'py'
		call setline(1, '#!/usr/bin/python ')
       call append(1, '# -*- coding: utf-8 -*-  ')
		call append(2, '# ')
		call append(3, '#       Filename: '.expand("%"))
		call append(4, '# ')
		call append(5, '#         Author: xwisen 1031649164@qq.com')
		call append(6, '#    Description: ---')
		call append(7, '#         Create: '.strftime("%Y-%m-%d %H:%M:%S"))
		call append(8, '#  Last Modified: '.strftime("%Y-%m-%d %H:%M:%S"))
		call append(9, '# ***********************************************')
		call append(10, '')

	elseif expand("%:e") == 'sh'
		call setline(1, '#!/bin/bash ')
		call append(1, '# ***********************************************')
		call append(2, '# ')
		call append(3, '#       Filename: '.expand("%"))
		call append(4, '# ')
		call append(5, '#         Author: xwisen 1031649164@qq.com')
		call append(6, '#    Description: ---')
		call append(7, '#         Create: '.strftime("%Y-%m-%d %H:%M:%S"))
		call append(8, '#  Last Modified: '.strftime("%Y-%m-%d %H:%M:%S"))
		call append(9, '# ***********************************************')
		call append(10, '')
	endif

endfunc

" multi-encoding
if has("multi_byte")
	" set bomb
        set fileencoding=utf-8
	set fileencodings=ucs-bom,utf-8,cp936,gb18030,gb2312,gbk,big5,euc-jp,euc-kr
	set encoding=utf8
	" CJK environment detection and corresponding setting
	if v:lang =~ "^zh_CN"
		" Use cp936 to support GBK, euc-cn == gb2312
		set encoding=cp936
		set termencoding=cp936
		set fileencoding=cp936
	elseif v:lang =~ "^zh_TW"
		" cp950, big5 or euc-tw
		" Are they equal to each other?
		set encoding=big5
		set termencoding=big5
		set fileencoding=big5
	elseif v:lang =~ "^ko"
		" Copied from someone's dotfile, untested
		set encoding=euc-kr
		set termencoding=euc-kr
		set fileencoding=euc-kr
	elseif v:lang =~ "^ja_JP"
		" Copied from someone's dotfile, untested
		set encoding=euc-jp
		set termencoding=euc-jp
		set fileencoding=euc-jp
	endif
		" Detect UTF-8 locale, and replace CJK setting if needed
		if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
			set encoding=utf-8
			set termencoding=utf-8
			set fileencoding=utf-8
		endif
else
	echoerr "Sorry, this version of (g)vim was not compiled without multi_byte"
endif
