if exists("g:autoloaded_note_markdown") || &cp
  finish
endif


" If the notes directory do not exist then make it otherwise do nothing
function! s:makeNoteDir()
	let dir = g:note_markdown_dir
	call mkdir(expand(dir), 'p')
	if isdirectory(dir)
		return dir
	else
		echoerr "Failed to make notes folder:".dir
	endif
	if filewritable(dir) != 2
		echoerr "Notes folder is not having write permission."
	endif
	return dir
endfunction


" If the notes directory do not exist then make it otherwise do nothing
function! note_markdown#MakeNoteFile(args)
	if (a:args[0]=='\') || (a:args[len(a:args)-1]=='\') || (a:args[0]=='/') || (a:args[len(a:args)-1]=='/')
		echoerr 'Note file name can not start or end with either of \ or /.'
		return
	endif
	let l:curr_note_file=g:note_markdown_dir.a:args
	" Remove any extension and make it markdown file
	let l:curr_note_file = fnamemodify(l:curr_note_file,':r').g:default_notes_extension
	if empty(glob(l:curr_note_file))
		let l:dir=fnamemodify( l:curr_note_file, ':p:h')
		if isdirectory(l:curr_note_file)
			echoerr "Can not create note as folder with same name exist."
			return
		endif
		call mkdir(expand(l:dir), 'p')
		if !isdirectory(l:dir)
			echoerr "Failed to make notes folder:".l:dir
			return
		endif
	endif
	wincmd l
	" Copy notes template with current notes extension
	" TODO: add variable to specify location and remove hardcode 
	if empty(glob(fnameescape(l:curr_note_file)))
		execute 'call system(''cp ~/Templates/notes-template' . g:default_notes_extension . ' ' . fnameescape(l:curr_note_file) . ''')'
	endif
	execute 'e' fnameescape(l:curr_note_file)
	if (g:open_note_folded==0)
		augroup note_markdown_buf
			au!
			au BufAdd,WinEnter <buffer> setf markdown.note|setlocal nofoldenable
		augroup END
	endif
	return expand(l:curr_note_file)
endfunction

function! s:noteAutocmd()
	augroup note_markdown
		au!
		" execute 'au BufEnter,CursorHold,CursorHoldI,BufUnload,WinLeave' '*'.g:default_notes_extension 'update'
		"execute 'au TextChanged,TextChangedI' '*'.g:default_notes_extension 'update'	"Great but too slow vim
	augroup END
endfunction

" show note folder
function! note_markdown#ShowNoteFolder()
	if (g:open_note_dir_in_split==0)
		execute 'e' fnameescape(g:note_markdown_dir)
	else
		if exists(':NERDTree')
			execute 'NERDTree' fnameescape(g:note_markdown_dir)|40winc|
			let s:is_nerdtree_used=1
		else
			execute 'vsplit' fnameescape(g:note_markdown_dir)|40winc|
		endif
	endif
endfunction

function! note_markdown#OpenNoteFuzzy()
	wincmd l
	if exists(':FZF')
		execute 'call fzf#run(fzf#wrap({''source'': ''find ' . g:note_markdown_dir . ' | grep ' . g:default_notes_extension . '$'',  ''down'' : ''35%''}))'
	elseif exists(':CtrlP')
		execute 'CtrlP' g:note_markdown_dir
	elseif exists(':Unite')
		execute 'Unite file file_rec/async' g:note_markdown_dir
	else
		echoerr "Neither FZF, CtrlP or Unite found for fuzzy search. Falling back to directory mode."
		call note_markdown#ShowNoteFolder()
	endif
endfunction

function! note_markdown#SearchNoteFiles(args)
	let l:curr_pwd=getcwd()
	" Changing the directory reduces the file path in quickfix window
	execute 'cd' g:note_markdown_dir
	if exists(':Ack')
		execute 'Ack' a:args
	elseif exists(':grep')
		execute 'grep -r -e' a:args '**'
	else
		execute 'vimgrep' a:args '**'
	endif
	execute 'cd' l:curr_pwd
endfunction

call s:makeNoteDir()
call s:noteAutocmd()

let g:autoloaded_note_markdown=1
