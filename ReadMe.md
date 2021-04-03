# vim-notes-markdown

## Credits ##
Fork of [vim-notes-markdown](https://github.com/mayanksuman/vim-notes-markdown), modified to work with my local LaTeX setup, where note files share a [common global template](https://www.ias.edu/math/computing/faq/local-latex-style-files).

## Addition ##
This fork applies the following modifications, which are useful to my note-taking setup:

* [fzf](https://github.com/junegunn/fzf.vim) only displays local notes (based on file extension) instead of the whole content of the notes folder.

* Initialization of note file from a common template for the selected file extension, currently hardcoded.

    **TODO**: add local variable `g:note_template`

* `NQ` command to create a quick note.


## Installation
Example of installation with [vim-plug](https://github.com/junegunn/vim-plug), by adding the following lines to your `.vimrc`.
```vim
Plug 'dedzago/vim-notes-markdown'
```

## Dependencies

This plugin need three different kinds of dependencies as listed in following table. All dependencies are optional. When dependencies are not present, this plugin fall back to some inbuilt function in vim, which may not provide the best user experience but serve the purpose.

| S.No. | Purpose                              | Supported Dependencies                                                                                                                    | Fall Back                    |
|-------|--------------------------------------|----------------------------------------|------------------------------|
| 1     | Displaying global note folder        | [NERDTree](https://github.com/scrooloose/nerdtree)             | netrw   |
| 2     | Fuzzy Search of file names in folder | [FZF](https://github.com/junegunn/fzf), [CtrlP](https://github.com/ctrlpvim/ctrlp.vim), [Unite](https://github.com/Shougo/unite.vim) | open the global notes folder |
| 3     | Search within all note files         | [Ack](https://github.com/mileszs/ack.vim)     | try to use grep otherwise vimgrep    |

For having good user experience, at least one of the dependencies for each category should be setup properly in vimrc. It is also desirable to use plugin with good syntax support for markdown. I recommend [vim-markdown](https://github.com/plasticboy/vim-markdown).

## Configuration Options

 - `g:note_markdown_dir` : The parent directory where the all the notes will be saved. (default location is `&l:runtimepath.'/note`, *i.e.*, `notes` folder in vim runtime path)

 - `g:open_note_dir_in_split` : Boolean, if set to 1 the note folder will be open in a split window.
(default: 0).

 - `g:default_notes_extension` : String, gives the file extension for the note files (default: ".md")

 - `g:open_note_folded` : Boolean, if set to 1 the note file will be opened with fold. Default is 0. 

Vim also respects the configuration provided at the end of file as comment. For example, adding `"set nofoldenable` will cause the the folds to be disable irrespective of setting of this plugin.

## Command Provided

 - `:NoteSearch` - Search all the notes directory for text (one argument needed)
 - `:NoteCreate` - Create new note by filename or folder structure. The command `:NoteCreate test` will create note file named `test` in global note directory. On the other hand, the command `:NoteCreate test/second_note` will create note file named `second_note` in `temp` directory of global note directory. Any number of nesting of folder structure is supported. This command also ignores the file extension and use the file extension specified in the configuration.
 - `:NoteFolder` - open the note folder.
 - `:NoteFuzzySearch` - Open note fuzzy search filtered by note extension. (fuzzy searching)
 - `:ToDo` - open ToDo file in note folder
 - `:NoteQuick` - Open a quick note in main folder with name `YYYY-MM-DD-quicknote-HHmm`
 
These commands have a corresponding short name (`:NS`, `:NC`, `:NF`, `:NFS`, `:TD`, and `:NQ`).

## Default mapping

 - `<leader>nf` is mapped to `:NoteFolder`
 - `<leader>nfs` is mapped to `:NoteFuzzySearch`
 - `<leader>nt` is mapped to `:ToDo`
 - `<leader>nn` is mapped to `:NoteQuick`

