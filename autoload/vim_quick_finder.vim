vim9script

var default_config = {
  ignore: ['.git/', '.svn/', 'node_modules/', '.cache', 'vendor/'],
  command: 'Qf'
}
var config = {}

def GetFiles(base_dir: string): list<string>
  var files = []
  var entries = readdir(base_dir)
  for entry in entries
    var path = base_dir == '.' ? entry : base_dir .. '/' .. entry
    if isdirectory(path)
      var should_ignore = false
      for ignore_pattern in config.ignore
        if path =~ ignore_pattern
          should_ignore = true
          break
        endif
      endfor
      if should_ignore
        continue
      endif
      files += GetFiles(path)
    else
      files->add(path)
    endif
  endfor
  return files
enddef

export def Exec(...args: list<string>)
  var keyword = get(args, 0, '')
  var base_dir = get(args, 1, '.')

  var raw_files = GetFiles(base_dir)
  var files = filter(raw_files, (idx, path) => {
    var is_matched = false
    for ignore_pattern in config.ignore
      if stridx(path, ignore_pattern) != -1
        is_matched = true
        break
      endif
    endfor
    return !is_matched
  })

  if keyword != ''
    files = matchfuzzy(files, keyword)
  endif
  sort(files)

  var qf_items = mapnew(files, (idx, path) => ({ filename: path, valid: true }))
  setqflist([], 'r', { title: 'Matched files: ' .. keyword, items: qf_items })
  copen
enddef

export def Setup(user_config: dict<any> = {})
  config = extendnew(default_config, user_config, 'force')
  execute $'command! -nargs=* -complete=dir {config.command} vim_quick_finder#Exec(<f-args>)'
enddef

