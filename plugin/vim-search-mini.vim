" Just a minimalist learning project about VimScript for searching text in file
" 
" Last update : 2022 Mar 29
" Maintainer  : Vincent Rouilhac [vincentrouilhac.com ; vrouilhacpe at gmail.com]
" Version     : 1.0

if exists('g:loaded_search_mini')
  finish
endif
let g:loaded_search_mini = 1

func VimSearchMiniGrepSearch(pattern)
  let value = system("grep -R " . a:pattern . " src")
  return value
endfunc

func SplitGrepResults(results)
  let splitted_results = split(strtrans(a:results), '\^@')
  let cleanned_results = []
  for i in splitted_results
    call add(cleanned_results, split(i, ":")[0])
  endfor
  return uniq(cleanned_results)
endfunc

func PrepareQFList(title, context)
  return { 'title': a:title, 'context': a:context }
endfunc

func BuildQFFilenameDictionnary(filename_list)
  let dictionnary = []
  for f in a:filename_list
    let dic = {}
    let dic.filename = f
    call add(dictionnary, dic)
  endfor
  return dictionnary 
endfunc

func VimSearchMini(pattern)
  let grep_value = VimSearchMiniGrepSearch(a:pattern)
  let grep_cleanned = SplitGrepResults(grep_value)
  let qflist_init = PrepareQFList("Search results", { 'cmd': 'grep' })
  let filenames = BuildQFFilenameDictionnary(grep_cleanned)
  call setqflist([], ' ', qflist_init)
  let qfid = getqflist({ 'nr': 0, 'id': 0 }).id
  call setqflist([], 'r', { 'id': qfid, 'items': filenames })
  :copen
endfunc

command -nargs=+ VimSearchMin :call VimSearchMini(<q-args>)
