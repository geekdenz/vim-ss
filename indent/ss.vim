setlocal indentexpr=SSIndent()

function! SSIndent()
	return HtmlIndentGet(v:lnum)
endfunction
