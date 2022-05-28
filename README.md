# Vim Search Mini

Very small plugin, ~60 lines, to search texts through files using the powerful
grep.

To use the command (run this inside vim)

```
:VimSearchMini
```

To add mappings (add this to .vimrc)
```
" map space or wathever
let mapleader = " "
nnoremap <leader>f :VimSearchMini 
```
By default the command will search to the current location vim is open at, to
custom the default location.
```
let g:vsm_default_location = "src"
```

You can configure what folders to exclude. (see --exclude-dir of grep doc)
```
let g:vsm_exclude_directories = "{.git,node_modules}"
```
