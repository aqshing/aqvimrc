noremap    <buffer>  <silent>  <LocalLeader>i0         :call C_CodeFor("up"    )<CR>
"vnoremap   <buffer>  <silent>  <LocalLeader>i0         :call C_CodeFor("up","v")<CR>
"noremap    <buffer>  <silent>  <LocalLeader>in         :call C_CodeFor("down"    )<CR>
"vnoremap   <buffer>  <silent>  <LocalLeader>in         :call C_CodeFor("down","v")<CR>
inoremap   <buffer>  <silent>  <LocalLeader>i0    <Esc>:call C_CodeFor("up"    )<CR>3ki
inoremap   <buffer>  <silent>  <LocalLeader>in    <Esc>:call C_CodeFor("down"    )<CR>3ki

== Statements.for block == nomenu ==
|Insert( 'Statements.for', '<SPLIT>' )|
== Statements.for == map:sfo, shortcut:f  ==
for ( |INIT|<CURSOR>; |CONDITION|; |INCREMENT| ) {
	<++>;
}

let s:MSWIN = has("win16") || has("win32")   || has("win64")     || has("win95")
let s:UNIX  = has("unix")  || has("macunix") || has("win32unix")
let s:C_GlobalTemplateFile	= ''
let s:C_ForTypes     = [
    \ 'char'                  ,
    \ 'int'                   ,
    \ 'long'                  ,
    \ 'long int'              ,
    \ 'long long'             ,
    \ 'long long int'         ,
    \ 'short'                 ,
    \ 'short int'             ,
    \ 'size_t'                ,
    \ 'unsigned'              , 
    \ 'unsigned char'         ,
    \ 'unsigned int'          ,
    \ 'unsigned long'         ,
    \ 'unsigned long int'     ,
    \ 'unsigned long long'    ,
    \ 'unsigned long long int',
    \ 'unsigned short'        ,
    \ 'unsigned short int'    ,
    \ ]
	
let g:C_Templates = NewLibrary ( 'api_version', '1.0' )

"
"----------------------------------------------------------------------
"  s:RegexSettings : The essential tokens of the grammar.   {{{2
"----------------------------------------------------------------------
"
let s:RegexSettings = {
			\ 'MacroName'      : '[a-zA-Z_][a-zA-Z0-9_]*',
			\ 'MacroList'      : '\%([a-zA-Z_]\|[a-zA-Z_][a-zA-Z0-9_ \t,]*[a-zA-Z0-9_]\)',
			\ 'TemplateName'   : '[a-zA-Z_][a-zA-Z0-9_+\-\., ]*[a-zA-Z0-9_+\-\.,]',
			\ 'TextOpt'        : '[a-zA-Z_][a-zA-Z0-9_+\-: \t,]*[a-zA-Z0-9_+\-]',
			\ 'Mapping'        : '[a-zA-Z0-9+\-]\+',
			\
			\ 'CommentStart'   : '\$',
			\ 'BlockDelimiter' : '==',
			\
			\ 'CommentHint'    : '$',
			\ 'CommandHint'    : '[A-Z]',
			\ 'DelimHint'      : '=',
			\ 'MacroHint'      : '|',
			\
			\ 'MacroStart'     : '|',
			\ 'MacroEnd'       : '|',
			\ 'EditTagStart'   : '<',
			\ 'EditTagEnd'     : '>',
			\ 'JumpTag1Start'  : '{',
			\ 'JumpTag1End'    : '}',
			\ 'JumpTag2Start'  : '<',
			\ 'JumpTag2End'    : '>',
			\ }
"
"
"----------------------------------------------------------------------
"  s:FileReadNameSpace : The set of functions a template file can call.   {{{2
"----------------------------------------------------------------------
"
let s:FileReadNameSpace_0_9 = {
			\ 'InterfaceVersion' : 's',
			\
			\ 'IncludeFile'  : 'ss\?',
			\ 'SetFormat'    : 'ss',
			\ 'SetMacro'     : 'ss',
			\ 'SetPath'      : 'ss',
			\ 'SetProperty'  : 'ss',
			\ 'SetStyle'     : 's',
			\
			\ 'SetMap'       : 'ss',
			\ 'SetShortcut'  : 'ss',
			\ 'SetMenuEntry' : 'ss',
			\ 'SetExpansion' : 'sss\?',
			\
			\ 'MenuShortcut' : 'ss',
			\ }
			
if	s:MSWIN
  " ==========  MS Windows  ======================================================
	"
	let s:plugin_dir = substitute( expand('<sfile>:p:h:h'), '\', '/', 'g' )
	"
	" change '\' to '/' to avoid interpretation as escape character
	if match(	substitute( expand("<sfile>"), '\', '/', 'g' ), 
				\		substitute( expand("$HOME"),   '\', '/', 'g' ) ) == 0
		"
		" USER INSTALLATION ASSUMED
		let g:C_Installation				= 'local'
		let s:C_LocalTemplateFile		= s:plugin_dir.'/c-support/templates/Templates'
	else
		"
		" SYSTEM WIDE INSTALLATION
		let g:C_Installation				= 'system'
		let s:C_GlobalTemplateFile  = s:plugin_dir.'/c-support/templates/Templates'
	endif
	"
  let s:C_FilenameEscChar 			= ''
	"
else
  " ==========  Linux/Unix  ======================================================
	"
	let s:plugin_dir	= expand('<sfile>:p:h:h')
	"
	if match( expand("<sfile>"), resolve( expand("$HOME") ) ) == 0
		" USER INSTALLATION ASSUMED
		let g:C_Installation				= 'local'
		let s:C_LocalTemplateFile		= s:plugin_dir.'/c-support/templates/Templates'
	else
		" SYSTEM WIDE INSTALLATION
		let g:C_Installation				= 'system'
		let s:C_GlobalTemplateFile  = s:plugin_dir.'/c-support/templates/Templates'
	endif
	"
  let s:C_FilenameEscChar 			= ' \%#[]'
	"
endif			
"
"------------------------------------------------------------------------------
"  C_CodeFor : for (idiom)       {{{1
"------------------------------------------------------------------------------
function! C_CodeFor( direction, ... ) range
	"
	let updown	= ( a:direction == 'up' ? 'INCR.' : 'DECR.' )
	let	string	= C_Input( 'Please input the variable name : ', '',
									\				'customlist,C_ForTypeComplete' )
	if empty(string)
		return
	endif

	let string	= substitute( string, '\s\+', ' ', 'g' )
	let nextindex			= -1
	let loopvar_type	= ''
	for item in sort( copy( s:C_ForTypes ) )
		let nextindex	= matchend( string, '^'.item )
		if nextindex > 0
			let loopvar_type	= item
			let	string				= strpart( string, nextindex )
		endif
	endfor
	if !empty(loopvar_type)
		let loopvar_type	.= ' '
		if empty(string)
			let	string	= C_Input( 'VARIABLE [START [END ['.updown.']]] : ', '' )
			if empty(string)
				return
			endif
		endif
	endif
	let part	= split( string )

	if len( part ) 	> 4
    echohl WarningMsg | echomsg "for loop construction : to many arguments " | echohl None
		return
	endif

	let missing	= 0
	while len(part) < 4
		let part	= part + ['']
		let missing	= missing+1
	endwhile

	let [ loopvar, startval, endval, incval ]	= part

	if empty(incval)
		let incval	= '1'
	endif

	if a:direction == 'up'
		if empty(endval)
			let endval	= 'n'
		endif
		if empty(startval)
			let startval	= '0'
		endif
		let txt_init = loopvar_type.loopvar.' = '.startval
		let txt_cond = loopvar.' < <++>'
		let txt_incr = '++'.loopvar
	else
		if empty(endval)
			let endval	= '0'
		endif
		if empty(startval)
			let startval	= 'n-1'
		endif
		let txt_init = loopvar_type.loopvar.' = '.startval
		let txt_cond = loopvar.' >= <++>'
		let txt_incr = '--'.loopvar
	endif
	"
	if a:0 == 0
		call InsertTemplate ( g:C_Templates, 'Statements.for block',
					\ '|INIT|', txt_init, '|CONDITION|', txt_cond, '|INCREMENT|', txt_incr,
					\ 'range', a:firstline, a:lastline )
	elseif a:0 == 1 && a:1 == 'v'
		call InsertTemplate ( g:C_Templates, 'Statements.for block',
					\ '|INIT|', txt_init, '|CONDITION|', txt_cond, '|INCREMENT|', txt_incr,
					\ 'range', a:firstline, a:lastline, 'v' )
	else
    echohl WarningMsg | echomsg "for loop construction : unknown argument ".a:1 | echohl None
	endif
	"
endfunction    " ----------  end of function C_CodeFor ----------
"
"
"----------------------------------------------------------------------
" InsertTemplate : Insert a template.   {{{1
"----------------------------------------------------------------------
"
function! InsertTemplate ( library, t_name, ... ) range
	"
	" ==================================================
	"  parameters
	" ==================================================
	"
	if type( a:library ) == type( '' )
		exe 'let t_lib = '.a:library
	elseif type( a:library ) == type( {} )
		let t_lib = a:library
	else
		return s:ErrorMsg ( 'Argument "library" must be given as a dict or string.' )
	endif
	"
	if type( a:t_name ) != type( '' )
		return s:ErrorMsg ( 'Argument "template_name" must be given as a string.' )
	endif
	"
	" ==================================================
	"  setup
	" ==================================================
	"
	" library and runtime information
	let s:library = t_lib
	let s:t_runtime = {
				\ 'obj_stack'   : [],
				\ 'macro_stack' : [],
				\ 'macros'      : {},
				\ 'prompted'    : {},
				\
				\ 'placement' : '',
				\ 'range'     : [ a:firstline, a:lastline ],
				\ }
	let regex = s:library.regex_template

	" handle folds internally (and save the state)
	if &foldenable
		let foldmethod_save = &foldmethod
		set foldmethod=manual
	endif
	" use internal formatting to avoid conflicts when using == below
	" (and save the state)
	let equalprg_save = &equalprg
	set equalprg=
	"
	let flag_mode = 'n'
	let options   = []
	"
	" ==================================================
	"  options
	" ==================================================
	"
	let i = 1
	while i <= a:0
		"
		if a:[i] == 'i' || a:[i] == 'insert'
			let flag_mode = 'i'
			let i += 1
		elseif a:[i] == 'v' || a:[i] == 'visual'
			let flag_mode = 'v'
			let i += 1
		elseif a:[i] == 'placement' && i+1 <= a:0
			let s:t_runtime.placement = a:[i+1]
			let i += 2
		elseif a:[i] == 'range' && i+2 <= a:0
			let s:t_runtime.range[0] = a:[i+1]
			let s:t_runtime.range[1] = a:[i+2]
			let i += 3
		elseif a:[i] == 'pick' && i+1 <= a:0
			call add ( options, 'pick' )
			call add ( options, a:[i+1] )
			let i += 2
		else
			if type ( a:[i] ) == type ( '' ) | call s:ErrorMsg ( 'Unknown option: "'.a:[i].'"' )
			else                             | call s:ErrorMsg ( 'Unknown option at position '.i.'.' ) | endif
			let i += 1
		endif
		"
	endwhile
	"
	" ==================================================
	"  do the job
	" ==================================================
	"
	try
		"
		" prepare the template for insertion
		if empty ( options )
			let [ text, placement, indentation ] = s:PrepareTemplate ( a:t_name, '<CURSOR>', '<SPLIT>' )
		else
			let [ text, placement, indentation ] = call ( 's:PrepareTemplate', [ a:t_name, '<CURSOR>', '<SPLIT>' ] + options )
		endif
		"
		if placement == 'help'
			" job already done, TODO: review this
		else
			"
			if ! empty ( s:t_runtime.placement )
				let placement = s:t_runtime.placement
			endif
			"
			" insert the text into the buffer
			let [ pos1, pos2 ] = s:InsertIntoBuffer ( text, placement, indentation, flag_mode )
			"
			" position the cursor
			call s:PositionCursor ( placement, flag_mode, pos1, pos2 )
			"
			" highlight jump targets
			call s:HighlightJumpTargets ( regex.JumpTagAll )
		endif
		"
	catch /Template:UserInputAborted/
		" noop
	catch /Template:Check:.*/
		"
		let templ = s:t_runtime.obj_stack[ -1 ]
		let msg   = v:exception[ len( 'Template:Check:') : -1 ]
		call s:ErrorMsg ( 'Checking "'.templ.'":', msg )
		"
	catch /Template:Prepare:.*/
		"
		let templ = s:t_runtime.obj_stack[ -1 ]
		let incld = len ( s:t_runtime.obj_stack ) == 1 ? '' : '(included by: "'.s:t_runtime.obj_stack[ -2 ].'")'
		let msg   = v:exception[ len( 'Template:Prepare:') : -1 ]
		call s:ErrorMsg ( 'Preparing "'.templ.'":', incld, msg )
		"
	catch /Template:Recursion/
		"
		let templ = s:t_runtime.obj_stack[ -1 ]
		let idx1  = index ( s:t_runtime.obj_stack, templ )
		let cont  = idx1 == 0 ? [] : [ '...' ]
		call call ( 's:ErrorMsg', [ 'Recursion detected while including the template/s:' ] + cont +
					\ s:t_runtime.obj_stack[ idx1 : -1 ] )
		"
	catch /Template:MacroRecursion/
		"
		let macro = s:t_runtime.macro_stack[ -1 ]
		let idx1  = index ( s:t_runtime.macro_stack, macro )
		let cont  = idx1 == 0 ? [] : [ '...' ]
		call call ( 's:ErrorMsg', [ 'Recursion detected while replacing the macro/s:' ] + cont +
					\ s:t_runtime.macro_stack[ idx1 : -1 ] )
		"
	catch /Template:Insert:.*/
		"
		let msg   = v:exception[ len( 'Template:Insert:') : -1 ]
		call s:ErrorMsg ( 'Inserting "'.a:t_name.'":', msg )
		"
	catch /Template:.*/
		"
		let msg = v:exception[ len( 'Template:') : -1 ]
		call s:ErrorMsg ( msg )
		"
	finally
		"
		" ==================================================
		"  wrap up
		" ==================================================
		"
		" restore the state: folding and formatter program
		if &foldenable
			exe "set foldmethod=".foldmethod_save
			normal! zv
		endif
		let &equalprg = equalprg_save
		"
		unlet s:library                             " remove script variables
		unlet s:t_runtime                           " ...
		"
	endtry
	"
endfunction    " ----------  end of function InsertTemplate  ----------
"
"
"------------------------------------------------------------------------------
"  C_Input: Input after a highlighted prompt     {{{1
"           3. argument : optional completion
"------------------------------------------------------------------------------
function! C_Input ( promp, text, ... )
	echohl Search																					" highlight prompt
	call inputsave()																			" preserve typeahead
	if a:0 == 0 || empty(a:1)
		let retval	=input( a:promp, a:text )
	else
		let retval	=input( a:promp, a:text, a:1 )
	endif
	call inputrestore()																		" restore typeahead
	echohl None																						" reset highlighting
	let retval  = substitute( retval, '^\s\+', "", "" )		" remove leading whitespaces
	let retval  = substitute( retval, '\s\+$', "", "" )		" remove trailing whitespaces
	return retval
endfunction    " ----------  end of function C_Input ----------
"
"
"----------------------------------------------------------------------
"  NewLibrary : Create a new template library.   {{{1
"----------------------------------------------------------------------
"
function! NewLibrary ( ... )

	" ==================================================
	"  options
	" ==================================================

	let api_version_str = '0.9'

	" ==================================================
	"  data
	" ==================================================

	" library
	let library   = {
				\ 'interface_str'   : '0.9',
				\ 'interface'       : 1000000,
				\
				\ 'macros'         : {},
				\ 'properties'     : {},
				\ 'resources'      : {},
				\ 'templates'      : {},
				\
				\ 'menu_order'     : [],
				\
				\ 'styles'         : [ 'default' ],
				\ 'current_style'  : 'default',
				\
				\ 'menu_shortcuts' : {},
				\ 'menu_existing'  : { 'base' : 0 },
				\
				\ 'regex_settings' : ( copy ( s:RegexSettings ) ),
				\ 'regex_file'     : {},
				\ 'regex_template' : {},
				\
				\ 'library_files'  : [],
				\ }
	" entries used by maps: 'map_commands!<filetype>'


	"call s:UpdateFileReadRegex ( library.regex_file,     library.regex_settings, library.interface )
	"call s:UpdateTemplateRegex ( library.regex_template, library.regex_settings, library.interface )

	" ==================================================
	"  wrap up
	" ==================================================

	return library      " return the new library

endfunction    " ----------  end of function NewLibrary  ----------
"
"----------------------------------------------------------------------
"  === Syntax: Regular Expressions ===   {{{1
"----------------------------------------------------------------------
"
"----------------------------------------------------------------------
"  s:RegexSettings : The essential tokens of the grammar.   {{{2
"----------------------------------------------------------------------
"
let s:RegexSettings = {
			\ 'MacroName'      : '[a-zA-Z_][a-zA-Z0-9_]*',
			\ 'MacroList'      : '\%([a-zA-Z_]\|[a-zA-Z_][a-zA-Z0-9_ \t,]*[a-zA-Z0-9_]\)',
			\ 'TemplateName'   : '[a-zA-Z_][a-zA-Z0-9_+\-\., ]*[a-zA-Z0-9_+\-\.,]',
			\ 'TextOpt'        : '[a-zA-Z_][a-zA-Z0-9_+\-: \t,]*[a-zA-Z0-9_+\-]',
			\ 'Mapping'        : '[a-zA-Z0-9+\-]\+',
			\
			\ 'CommentStart'   : '\$',
			\ 'BlockDelimiter' : '==',
			\
			\ 'CommentHint'    : '$',
			\ 'CommandHint'    : '[A-Z]',
			\ 'DelimHint'      : '=',
			\ 'MacroHint'      : '|',
			\
			\ 'MacroStart'     : '|',
			\ 'MacroEnd'       : '|',
			\ 'EditTagStart'   : '<',
			\ 'EditTagEnd'     : '>',
			\ 'JumpTag1Start'  : '{',
			\ 'JumpTag1End'    : '}',
			\ 'JumpTag2Start'  : '<',
			\ 'JumpTag2End'    : '>',
			\ }
"
"----------------------------------------------------------------------
"  s:UpdateFileReadRegex : Update the regular expressions.   {{{2
"----------------------------------------------------------------------
"
function! s:UpdateFileReadRegex ( regex, settings, interface )
	"
	let quote = '\(["'']\?\)'
	"
	" Basics
	let a:regex.MacroName     = a:settings.MacroName
	let a:regex.MacroNameC    = '\('.a:settings.MacroName.'\)'
	let a:regex.TemplateNameC = '\('.a:settings.TemplateName.'\)'
	let a:regex.Mapping       = a:settings.Mapping
	let a:regex.AbsolutePath  = '^[\~/]'                " TODO: Is that right and/or complete?
	"
	" Syntax Categories
	let a:regex.EmptyLine     = '^\s*$'
	let a:regex.CommentLine   = '^'.a:settings.CommentStart
	let a:regex.FunctionCall  = '^\s*'.a:regex.MacroNameC.'\s*(\(.*\))\s*$'
	let a:regex.MacroAssign   = '^\s*'.a:settings.MacroStart.a:regex.MacroNameC.a:settings.MacroEnd
				\                    .'\s*=\s*'.quote.'\(.\{-}\)'.'\2'.'\s*$'   " deprecated
	"
	" Blocks
	let delim                 = a:settings.BlockDelimiter
	let a:regex.Styles1Hint   = '^'.delim.'\s*IF\s\+|STYLE|\s\+IS\s'
	let a:regex.Styles1Start  = '^'.delim.'\s*IF\s\+|STYLE|\s\+IS\s\+'.a:regex.MacroNameC.'\s*'.delim
	let a:regex.Styles1End    = '^'.delim.'\s*ENDIF\s*'.delim

	let a:regex.Styles2Hint   = '^'.delim.'\s*USE\s\+STYLES\s*:'
	let a:regex.Styles2Start  = '^'.delim.'\s*USE\s\+STYLES\s*:'
				\                     .'\s*\('.a:settings.MacroList.'\)'.'\s*'.delim
	let a:regex.Styles2End    = '^'.delim.'\s*ENDSTYLES\s*'.delim
	"
	let a:regex.FiletypeHint  = '^'.delim.'\s*USE\s\+FILETYPES\s*:'
	let a:regex.FiletypeStart = '^'.delim.'\s*USE\s\+FILETYPES\s*:'
				\                     .'\s*\('.a:settings.MacroList.'\)'.'\s*'.delim
	let a:regex.FiletypeEnd   = '^'.delim.'\s*ENDFILETYPES\s*'.delim
	"
	" Texts
	let a:regex.TemplateHint  = '^'.delim.'\s*\%(TEMPLATE:\)\?\s*'.a:settings.TemplateName.'\s*'.delim
				\                     .'\s*\%(\('.a:settings.TextOpt.'\)\s*'.delim.'\)\?'
	let a:regex.TemplateStart = '^'.delim.'\s*\%(TEMPLATE:\)\?\s*'.a:regex.TemplateNameC.'\s*'.delim
				\                     .'\s*\%(\('.a:settings.TextOpt.'\)\s*'.delim.'\)\?'
	let a:regex.TemplateEnd   = '^'.delim.'\s*ENDTEMPLATE\s*'.delim
	"
	let a:regex.HelpHint      = '^'.delim.'\s*HELP:'
	let a:regex.HelpStart     = '^'.delim.'\s*HELP:\s*'.a:regex.TemplateNameC.'\s*'.delim
				\                     .'\s*\%(\('.a:settings.TextOpt.'\)\s*'.delim.'\)\?'
	"let a:regex.HelpEnd       = '^'.delim.'\s*ENDHELP\s*'.delim
	"
	let a:regex.MenuSepHint   = '^'.delim.'\s*SEP:'
	let a:regex.MenuSep       = '^'.delim.'\s*SEP:\s*'.a:regex.TemplateNameC.'\s*'.delim
	"
	let a:regex.ListHint      = '^'.delim.'\s*LIST:'
	let a:regex.ListStart     = '^'.delim.'\s*LIST:\s*'.a:regex.MacroNameC.'\s*'.delim
				\                     .'\s*\%(\('.a:settings.TextOpt.'\)\s*'.delim.'\)\?'
	let a:regex.ListEnd       = '^'.delim.'\s*ENDLIST\s*'.delim
	"
	" Special Hints
	let a:regex.CommentHint   = a:settings.CommentHint
	let a:regex.CommandHint   = a:settings.CommandHint
	let a:regex.DelimHint     = a:settings.DelimHint
	let a:regex.MacroHint     = a:settings.MacroHint
	"
endfunction    " ----------  end of function s:UpdateFileReadRegex  ----------
"
"----------------------------------------------------------------------
"  s:UpdateTemplateRegex : Update the regular expressions.   {{{2
"----------------------------------------------------------------------
"
function! s:UpdateTemplateRegex ( regex, settings, interface )
	"
	let quote = '["'']'
	"
	" Function Arguments
	let a:regex.RemoveQuote  = '^\s*'.quote.'\zs.*\ze'.quote.'\s*$'
	"
	" Basics
	let a:regex.MacroStart   = a:settings.MacroStart
	let a:regex.MacroEnd     = a:settings.MacroEnd
	let a:regex.MacroName    = a:settings.MacroName
	let a:regex.MacroNameC   = '\('.a:settings.MacroName.'\)'
	let a:regex.MacroMatch   = '^'.a:settings.MacroStart.a:settings.MacroName.a:settings.MacroEnd.'$'
	"
	" Syntax Categories
	let a:regex.FunctionLine    = '^'.a:settings.MacroStart.'\('.a:regex.MacroNameC.'(\(.*\))\)'.a:settings.MacroEnd.'\s*\n'
	let a:regex.FunctionChecked = '^'.a:regex.MacroNameC.'(\(.*\))$'
	let a:regex.FunctionList    = '^LIST(\(.\{-}\))$'
	let a:regex.FunctionComment = a:settings.MacroStart.'\(C\|Comment\)'.'(\(.\{-}\))'.a:settings.MacroEnd
	let a:regex.FunctionInsert  = a:settings.MacroStart.'\(Insert\|InsertLine\)'.'(\(.\{-}\))'.a:settings.MacroEnd
	let a:regex.MacroRequest    = a:settings.MacroStart.'?'.  a:regex.MacroNameC.   '\(:\a\)\?'. '\(%\%([-+*]\+\|[-+*]\?\d\+\)[lcr]\?\)\?'.a:settings.MacroEnd
	let a:regex.MacroInsert     = a:settings.MacroStart.'?\?'.a:regex.MacroNameC.   '\(:\a\)\?'. '\(%\%([-+*]\+\|[-+*]\?\d\+\)[lcr]\?\)\?'.a:settings.MacroEnd
	let a:regex.MacroNoCapture  = a:settings.MacroStart.'?\?'.a:settings.MacroName.'\%(:\a\)\?'.'\%(%[-+*]*\d*[lcr]\?\)\?'.                a:settings.MacroEnd
	let a:regex.ListItem        = a:settings.MacroStart.''.a:regex.MacroNameC.':ENTRY_*'.a:settings.MacroEnd
	let a:regex.LeftRightSep    = a:settings.MacroStart.'<\+>\+'.a:settings.MacroEnd
	"
	let a:regex.TextBlockFunctions = '^\%(C\|Comment\|Insert\|InsertLine\)$'
	"
	if a:interface >= 1000000
		let a:regex.JumpTagAll   = '<-\w*->\|{-\w*-}\|\[-\w*-]\|<+\w*+>\|{+\w*+}\|\[+\w*+]'
		let a:regex.JumpTagType2 = '<-\w*->\|{-\w*-}\|\[-\w*-]'
		let a:regex.JumpTagOpt   = '\[-\w*-]\|\[+\w*+]'
		let a:regex.JTListSep    = ','
	endif
	"
endfunction    " ----------  end of function s:UpdateTemplateRegex  ----------
" }}}2
"----------------------------------------------------------------------
"
"
"----------------------------------------------------------------------
" s:PrepareTemplate : Prepare a template for insertion.   {{{2
"----------------------------------------------------------------------
"
function! s:PrepareTemplate ( name, ... )
	"
	let regex = s:library.regex_template
	"
	" ==================================================
	"  setup and checks
	" ==================================================
	"
	" check for recursion
	if -1 != index ( s:t_runtime.obj_stack, a:name )
		call add ( s:t_runtime.obj_stack, a:name )
		throw 'Template:Recursion'
	endif
	"
	call add ( s:t_runtime.obj_stack, a:name )
	"
	" current style
	let style = s:library.current_style
	"
	" get the template
	let [ cmds, text, type, placement, indentation ] = s:GetTemplate ( a:name, style )
	"
	" current macros
	let m_local  = s:t_runtime.macros
	let prompted = s:t_runtime.prompted
	"
	let remove_cursor  = 1
	let remove_split   = 1
	let use_surround   = 0
	let use_split      = 0
	"
	let revert = ''
	"
	" ==================================================
	"  parameters
	" ==================================================
	"
	let i = 1
	while i <= a:0
		"
		if a:[i] =~ regex.MacroMatch && i+1 <= a:0
			let m_name = matchlist ( a:[i], regex.MacroNameC )[1]
			if has_key ( m_local, m_name )
				let revert = 'let  m_local["'.m_name.'"] = '.string( m_local[ m_name ] ).' | '.revert
			else
				let revert = 'call remove ( m_local, "'.m_name.'" ) | '.revert
			endif
			let m_local[ m_name ] = a:[i+1]
			let i += 2
		elseif a:[i] =~ '<CURSOR>\|{CURSOR}'
			let remove_cursor = 0
			let i += 1
		elseif a:[i] == '<SPLIT>'
			let remove_split = 0
			let i += 1
		elseif a:[i] == 'do_surround'
			let use_surround = 1
			let i += 1
		elseif a:[i] == 'use_split'
			let use_split    = 1
			let remove_split = 0
			let i += 1
		elseif a:[i] == 'pick' && i+1 <= a:0
			let cmds = "PickEntry( '', ".string(a:[i+1])." )\n".cmds
			let i += 2
		else
			if type ( a:[i] ) == type ( '' ) | call s:ErrorMsg ( 'Unknown option: "'.a:[i].'"' )
			else                             | call s:ErrorMsg ( 'Unknown option at position '.i.'.' ) | endif
			let i += 1
		endif
		"
	endwhile
	"
	" ==================================================
	"  prepare
	" ==================================================
	"
	if type == 't'
		let text = s:PrepareStdTempl( cmds, text, a:name )
"		" TODO: remove this code:
" 	elseif type == 'pick-file'
" 		let text = s:PreparePickFile( cmds, text )
" 	elseif type == 'pick-list'
" 		let text = s:PreparePickList( cmds, text )
	elseif type == 'help'
		let text = s:PrepareHelp( cmds, text )
	endif
	"
	if remove_cursor
		let text = substitute( text, '<CURSOR>\|{CURSOR}',   '', 'g' )
		let text = substitute( text, '<RCURSOR>\|{RCURSOR}', '         ', 'g' )
	endif
	if remove_split
		let text = s:LiteralReplacement( text, '<SPLIT>',  '', 'g' )
	endif
	if ! use_surround || use_split
		let text = s:LiteralReplacement( text, '<CONTENT>',  '', 'g' )
	endif
	"
	" ==================================================
	"  wrap up
	" ==================================================
	"
	exe revert
	"
	call remove ( s:t_runtime.obj_stack, -1 )
	"
	if use_split
		return [ text, 'SPLIT' ]
	elseif use_surround
		return [ text, 'CONTENT' ]
	else
		return [ text, placement, indentation ]
	endif
	"
endfunction    " ----------  end of function s:PrepareTemplate  ----------
" }}}2
"-------------------------------------------------------------------------------
"
"
"----------------------------------------------------------------------
" s:GetTemplate : Get a template.   {{{2
"----------------------------------------------------------------------
"
function! s:GetTemplate ( name, style )
	"
	let name  = a:name
	let style = a:style
	"
	" check the template
	let s:library.templates = s:C_GlobalTemplateFile
	if has_key ( s:library.templates, name.'!!type' )
		let info = s:library.templates[ a:name.'!!type' ]
	else
		throw 'Template:Prepare:template does not exist'
	endif
	"
	if style == '!any'
		for s in s:library.styles
			if has_key ( s:library.templates, name.'!'.s )
				let template = get ( s:library.templates, name.'!'.s )
				let style    = s
			endif
		endfor
	else
		" check the style
		if has_key ( s:library.templates, name.'!'.style )
			let template = get ( s:library.templates, name.'!'.style )
		elseif has_key ( s:library.templates, name.'!default' )
			let template = get ( s:library.templates, name.'!default' )
			let style    = 'default'
		elseif style == 'default'
			throw 'Template:Prepare:template does not have the default style'
		else
			throw 'Template:Prepare:template has neither the style "'.style.'" nor the default style'
		endif
	endif
	"
	" check the text
	let head = template[ 0 : 5 ]
	"
	if head == "|P()|\n"          " plain text
		" TODO: special type for plain
		let cmds = ''
		let text = template[ 6 : -1 ]
	elseif head == "|T()|\n"      " only text (contains only macros without '?')
		let cmds = ''
		let text = template[ 6 : -1 ]
	elseif head == "|C()|\n"      " command and text block
		let splt = stridx ( template, "|T()|\n" ) - 1
		let cmds = template[ 6 : splt ]
		let text = template[ splt+7 : -1 ]
	else
		"
		" do checks
		let [ cmds, text ] = s:CheckTemplate ( template, info.type )
		"
		" save the result
		if empty ( cmds )
			let template = "|T()|\n".text
		else
			let template = "|C()|\n".cmds."|T()|\n".text
		end
		let s:library.templates[ a:name.'!'.style  ] = template
		"
	end
	"
	return [ cmds, text, info.type, info.placement, info.indentation ]
endfunction    " ----------  end of function s:GetTemplate  ----------
"
"-------------------------------------------------------------------------------
function! s:ErrorMsg ( ... )
	echohl WarningMsg
	for line in a:000
		echomsg line
	endfor
	echohl None
endfunction    " ----------  end of function s:ErrorMsg  ----------

function! s:GetGlobalSetting ( varname, ... )
	let lname = a:varname
	let gname = a:0 >= 1 ? a:1 : lname
	if exists ( 'g:'.gname )
		let { 's:'.lname } = { 'g:'.gname }
	endif
endfunction    " ----------  end of function s:GetGlobalSetting  ----------
call s:GetGlobalSetting( 'C_GlobalTemplateFile' )