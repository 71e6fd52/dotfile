if exists("b:current_syntax")
  finish
endif

syn match Comment "\..*$"
syn match Type "^[A-Z]"
syn match Statement "^[a-z+]"
