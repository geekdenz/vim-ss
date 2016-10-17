setlocal indentexpr=SSIndent()

function! SSIndent()
	let ssifstart = '<%\s*if.*%>'
	let ssifend = '<%\s*end_if.*%>'
	let starttags = ['<%\s*if.*%>']
	let endtags = ['<%\s*end_if.*%>']
	let ssmiddle = '(!?<%\s*(end_if|if.*)\s*%>)'

    let line = getline(v:lnum)
    let previousNum = prevnonblank(v:lnum - 1)
    let previous = getline(previousNum)
	let i = 0
	for starttag in starttags
		let endtag = entags[i]
		let pairbefore = searchpair(starttag, '', endtag, 'b')
		echom "Pair: ". pairbefore
		let i += 1
	endfor

	" echo "previous: ". previous
    if (previous =~ "<%\\s*if.*%>" && previous !~ "<%\\s*end_if\\s*%>" && line !~ "<%\\s*end_if\\s*%>") 
        \ || (previous =~ "<%\\s*else.*%>" && previous !~ "<%\\s*end_else\\s*%>" && line !~ "<%\\s*end_else\\s*%>") 
        \ || (previous =~ "<%\\s*else_if.*%>" && previous !~ "<%\\s*end_loop\\s*%>" && line !~ "<%\\s*end_loop\\s*%>") 
        \ || (previous =~ "<%\\s*loop.*%>" && previous !~ "<%\\s*end_loop\\s*%>" && line !~ "<%\\s*end_loop\\s*%>") 
        \ || (previous =~ "<%\\s*control.*%>" && previous !~ "<%\\s*end_control\\s*%>" && line !~ "<%\\s*end_control\\s*%>") 
        \ || (previous =~ "<%\\s*with.*%>" && previous !~ "<%\\s*end_with\\s*%>" && line !~ "<%\\s*end_with\\s*%>") 
        return indent(previousNum + 1)
		" + &tabstop
    else
		return HtmlIndentGet(v:lnum)
    endif
endfunction
