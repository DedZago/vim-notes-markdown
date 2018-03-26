if &cp || exists('g:pluginloaded_note_markdown')
	finish
endif

"Get default notes directory -- only called if user do not specify notes folder
function! s:getDefaultNoteDir()
	for dir in split(&l:runtimepath, ",")
		if isdirectory(expand(dir))
			return expand(dir) . '/notes'
		endif
	endfor
endfunction

if !exists('g:note_markdown_dir')
	let g:note_markdown_dir = s:getDefaultNoteDir()
endif
let dir_list = split(g:note_markdown_dir, ",")
let g:note_markdown_dir =fnamemodify(dir_list[0],':p:h').'/'

if !exists('g:default_notes_extension')
	let g:default_notes_extension='.md'
endif

if !exists('g:open_note_dir_in_split')
	let g:open_note_dir_in_split=0
endif

if !exists('g:open_note_folded')
	let g:open_note_folded=0
endif

" Longer detailed commands
command! -nargs=1 NoteSearch call note_markdown#SearchNoteFiles(<f-args>)
command! NoteFuzzySearch call note_markdown#OpenNoteFuzzy()
command! -nargs=1 NoteCreate call note_markdown#MakeNoteFile(<f-args>)
command! NoteFolder call note_markdown#ShowNoteFolder()
command! ToDo call note_markdown#MakeNoteFile('ToDo')

" Short commands
command! -nargs=1 NS call note_markdown#SearchNoteFiles(<f-args>)
command! NFS call note_markdown#OpenNoteFuzzy()
command! -nargs=1 NC call note_markdown#MakeNoteFile(<f-args>)
command! NF call note_markdown#ShowNoteFolder()
command! TD call note_markdown#MakeNoteFile('ToDo')

"Some maps
map <leader>nfs :NoteFuzzySearch<cr>
map <leader>nf :NoteFolder<cr>
map <leader>td :TD<cr>

let g:pluginloaded_note_markdown=1
