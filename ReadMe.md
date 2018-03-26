# vim-notes-markdown

## Note taking in 'GitHub Flavored' markdown in vim

This plugin helps in two fronts: It allows you to take notes in markdown and organizes them in global notes folder (that can be synced between multiple devices using any sync service like DropBox, NextCloud). Motivation behind this plugin are:

 - Markdown is a great way to take notes. Some note-taking tools do allow to take notes in markdown. However, these tools most often store the notes in some other formats leading to incompatibility between different platforms (if the same program is not available on the other platform).
 - The statement that "notes is stored as text" is not equivalent to "notes are easier to read". For instance, xml, json, html or yaml are text based but it is difficult to read. Considering this and above point I want to strictly limit myself to markdown as note taking and storage format.
 - I do not want to leave the comfort of vim for any awesome note-taking application (doesn't matter how awesome features it has). Some applications do provide vim mode, but, they cannot use my vimrc and, hence, cannot take advantage of different plugins and customizations I use on vim.

## Installation
The plugin can be installed using [Pathogen](https://github.com/tpope/vim-pathogen), [Vundle](https://github.com/gmarik/vundle) or [vim-plug](https://github.com/junegunn/vim-plug).
If you use [Pathogen](https://github.com/tpope/vim-pathogen), following commands in shell will install this plugin:

```sh
cd ~/.vim/bundle && git clone https://github.com/mayanksuman/vim-notes-markdown
```
If you use [Vundle](https://github.com/gmarik/vundle), then adding following lines in vimrc will help.
```vim
Plugin mayanksuman/vim-notes-markdown
```
If you use [vim-plug](https://github.com/junegunn/vim-plug), then add following lines in your vimrc.
```vim
Plug mayanksuman/vim-notes-markdown
```

## Dependencies

This plugin need three different kinds of dependencies as listed in following table. All dependencies are optional. When dependencies are not present, this plugin fall back to some inbuilt function in vim, which may not provide best user experience but serve the purpose.

| S.No. | Purpose                              | Supported Dependencies                                                                                                                    | Fall Back                    |
|-------|--------------------------------------|----------------------------------------|------------------------------|
| 1     | Displaying global note folder        | [NERDTree](https://github.com/scrooloose/nerdtree)             | netrw   |
| 2     | Fuzzy Search of file names in folder | [FZF](https://github.com/junegunn/fzf), [CtrlP](https://github.com/ctrlpvim/ctrlp.vim), [Unite](https://github.com/Shougo/unite.vim) | open the global notes folder |
| 3     | Search within all note files         | [Ack](https://github.com/mileszs/ack.vim)     | try to use grep otherwise vimgrep    |

For having good user experience, at least one of the dependencies for each category should be setup properly in vimrc. It is also desirable to use plugin with good syntax support for markdown. I recommend [vim-markdown](https://github.com/plasticboy/vim-markdown).

## Configuration Options

 - `g:note_markdown_dir` : The parent directory where the all the notes will be saved. (default location is `&l:runtimepath.'/note`, *i.e.*, `notes` folder in vim runtime path)
 - `g:open_note_dir_in_split` : A boolean if set will open the note folder in split. By default note folder is not open in split (default: 0).
 - `g:default_notes_extension` : Default is `.md`. It can be changed to other extension like `.note.md`. However, changing the extension do not change the storage format. The file is still stored as markdown.
 - `g:open_note_folded` : If set to 0, the notes file will be opened without fold. Default is 0. 

Vim also respect the configuration provided at the end of file as comment. For example, adding `"set nofoldenable` will cause the the folds to be disable irrespective of setting of this plugin.

## Command Provided

 - `:NoteSearch` - Search all the notes directory for text (one argument needed)
 - `:NoteCreate` - make new note with filename or folder structure. (take file name with folder structure). The command `:NoteCreate test` will create note file named `first_note` in global note directory. On the other hand, the command `:NoteCreate test\second_note` will create note file named `second_note` in `temp` directory of global note directory. Any number of nesting of folder structure is supported. This command also ignores the file extension and use the file extension setup in configuration.
 - `:NoteFolder` - open the note folder.
 - `:NoteFuzzySearch` - Open the note file matching with the filename. (fuzzy searching)
 - `:ToDo` - open ToDo file in note folder

	 These commands have shorter names too (`:NS`, `:NC`, `:NF`, `:NFS` and `:TD`).

## Default mapping

 - `<leader>nf` is mapped to `:NoteFolder`
 - `<leader>nfs` is mapped to `:NoteFuzzySearch`
 - `<leader>td` is mapped to `:ToDo`


## Known Issues

The default extension for note file is `.md`. It causes a issue that all buffers having markdown file are saved automatically at various events like `BufEnter, CursorHold, CursorHoldI, BufUnload, WinLeave`. This behavior is however seems favorable to me. (so, not an issue I guess)

