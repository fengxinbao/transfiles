illl

'sdfs' 
{[[{ [ sdss "  hello   word" sdfsdf ] }]]}
("hello" word)
"hello word"
[ hello ] word
( vim )


(  )	"( (hello") ) word

1. Motions and operators				*operator*

The motion commands can be used after an operator command, to have the command
operate on the text that was moved over.  That is the text between the cursor
position before and after the motion.  Operators are generally used to delete
or change text.  The following operators are available:

	|c|	c	change
	|d|	d	delete
	|y|	y	yank into register (does not change the text)
	|~|	~	swap case (only if 'tildeop' is set)
	|g~|	g~	swap case
	|gu|	gu	make lowercase
	|gU|	gU	make uppercase
	|!|	!	filter through an external program
	|=|	=	filter through 'equalprg' or C-indenting if empty
	|gq|	gq	text formatting
	|g?|	g?	ROT13 encoding
	|>|	>	shift right
	|<|	<	shift left
	|zf|	zf	define a fold
	|g@|	g@	call function set with the 'operatorfunc' option

If the motion includes a count and the operator also had a count before it,
the two counts are multiplied.  For example: "2d3w" deletes six words.

After applying the operator the cursor is mostly left at the start of the text
that was operated upon.  For example, "yfe" doesn't move the cursor, but "yFe"
moves the cursor leftwards to the "e" where the yank started.

6. Text object selection			*object-select* *text-objects*
						*v_a* *v_i*

This is a series of commands that can only be used while in Visual mode or
after an operator.  The commands that start with "a" select "a"n object
including white space, the commands starting with "i" select an "inner" object
without white space, or just the white space.  Thus the "inner" commands
always select less text than the "a" commands.

These commands are {not in Vi}.
These commands are not available when the |+textobjects| feature has been
disabled at compile time.
Also see `gn` and `gN`, operating on the last search pattern.

							*v_aw* *aw*
aw			"a word", select [count] words (see |word|).
			Leading or trailing white space is included, but not
			counted.
			When used in Visual linewise mode "aw" switches to
			Visual characterwise mode.

							*v_iw* *iw*
iw			"inner word", select [count] words (see |word|).
			White space between words is counted too.
			When used in Visual linewise mode "iw" switches to
			Visual characterwise mode.

							*v_aW* *aW*
aW			"a WORD", select [count] WORDs (see |WORD|).
			Leading or trailing white space is included, but not
			counted.
			When used in Visual linewise mode "aW" switches to
			Visual characterwise mode.

							*v_iW* *iW*
iW			"inner WORD", select [count] WORDs (see |WORD|).
			White space between words is counted too.
			When used in Visual linewise mode "iW" switches to
			Visual characterwise mode.

							*v_as* *as*
as			"a sentence", select [count] sentences (see
			|sentence|).
			When used in Visual mode it is made characterwise.

							*v_is* *is*
is			"inner sentence", select [count] sentences (see
			|sentence|).
			When used in Visual mode it is made characterwise.

							*v_ap* *ap*
ap			"a paragraph", select [count] paragraphs (see
			|paragraph|).
			Exception: a blank line (only containing white space)
			is also a paragraph boundary.
			When used in Visual mode it is made linewise.

							*v_ip* *ip*
ip			"inner paragraph", select [count] paragraphs (see
			|paragraph|).
			Exception: a blank line (only containing white space)
			is also a paragraph boundary.
			When used in Visual mode it is made linewise.

a]						*v_a]* *v_a[* *a]* *a[*
a[			"a [] block", select [count] '[' ']' blocks.  This
			goes backwards to the [count] unclosed '[', and finds
			the matching ']'.  The enclosed text is selected,
			including the '[' and ']'.
			When used in Visual mode it is made characterwise.

i]						*v_i]* *v_i[* *i]* *i[*
i[			"inner [] block", select [count] '[' ']' blocks.  This
			goes backwards to the [count] unclosed '[', and finds
			the matching ']'.  The enclosed text is selected,
			excluding the '[' and ']'.
			When used in Visual mode it is made characterwise.

a)							*v_a)* *a)* *a(*
a(							*v_ab* *v_a(* *ab*
ab			"a block", select [count] blocks, from "[count] [(" to
			the matching ')', including the '(' and ')' (see
			|[(|).  Does not include white space outside of the
			parenthesis.
			When used in Visual mode it is made characterwise.

i)							*v_i)* *i)* *i(*
i(							*v_ib* *v_i(* *ib*
ib			"inner block", select [count] blocks, from "[count] [("
			to the matching ')', excluding the '(' and ')' (see
			|[(|).
			When used in Visual mode it is made characterwise.

a>						*v_a>* *v_a<* *a>* *a<*
a<			"a <> block", select [count] <> blocks, from the
			[count]'th unmatched '<' backwards to the matching
			'>', including the '<' and '>'.
			When used in Visual mode it is made characterwise.

i>						*v_i>* *v_i<* *i>* *i<*
i<			"inner <> block", select [count] <> blocks, from
			the [count]'th unmatched '<' backwards to the matching
			'>', excluding the '<' and '>'.
			When used in Visual mode it is made characterwise.

						*v_at* *at*
at			"a tag block", select [count] tag blocks, from the
			[count]'th unmatched "<aaa>" backwards to the matching
			"</aaa>", including the "<aaa>" and "</aaa>".
			See |tag-blocks| about the details.
			When used in Visual mode it is made characterwise.

						*v_it* *it*
it			"inner tag block", select [count] tag blocks, from the
			[count]'th unmatched "<aaa>" backwards to the matching
			"</aaa>", excluding the "<aaa>" and "</aaa>".
			See |tag-blocks| about the details.
			When used in Visual mode it is made characterwise.

a}							*v_a}* *a}* *a{*
a{							*v_aB* *v_a{* *aB*
aB			"a Block", select [count] Blocks, from "[count] [{" to
			the matching '}', including the '{' and '}' (see
			|[{|).
			When used in Visual mode it is made characterwise.

i}							*v_i}* *i}* *i{*
i{							*v_iB* *v_i{* *iB*
iB			"inner Block", select [count] Blocks, from "[count] [{"
			to the matching '}', excluding the '{' and '}' (see
			|[{|).
			When used in Visual mode it is made characterwise.

a"							*v_aquote* *aquote*
a'							*v_a'* *a'*
a`							*v_a`* *a`*
			"a quoted string".  Selects the text from the previous
			quote until the next quote.  The 'quoteescape' option
			is used to skip escaped quotes.
			Only works within one line.
			When the cursor starts on a quote, Vim will figure out
			which quote pairs form a string by searching from the
			start of the line.
			Any trailing white space is included, unless there is
			none, then leading white space is included.
			When used in Visual mode it is made characterwise.
			Repeating this object in Visual mode another string is
			included.  A count is currently not used.

i"							*v_iquote* *iquote*
i'							*v_i'* *i'*
i`							*v_i`* *i`*
			Like a", a' and a`, but exclude the quotes and
			repeating won't extend the Visual selection.
			Special case: With a count of 2 the quotes are
			included, but no extra white space as with a"/a'/a`.

When used after an operator:
For non-block objects:
	For the "a" commands: The operator applies to the object and the white
	space after the object.  If there is no white space after the object
	or when the cursor was in the white space before the object, the white
	space before the object is included.
	For the "inner" commands: If the cursor was on the object, the
	operator applies to the object.  If the cursor was on white space, the
	operator applies to the white space.
For a block object:
	The operator applies to the block where the cursor is in, or the block
	on which the cursor is on one of the braces.  For the "inner" commands
	the surrounding braces are excluded.  For the "a" commands, the braces
	are included.

When used in Visual mode:
When start and end of the Visual area are the same (just after typing "v"):
	One object is selected, the same as for using an operator.
When start and end of the Visual area are not the same:
	For non-block objects the area is extended by one object or the white
	space up to the next object, or both for the "a" objects.  The
	direction in which this happens depends on which side of the Visual
	area the cursor is.  For the block objects the block is extended one
	level outwards.

For illustration, here is a list of delete commands, grouped from small to big
objects.  Note that for a single character and a whole line the existing vi
movement commands are used.
	"dl"	delete character (alias: "x")		|dl|
	"diw"	delete inner word			*diw*
	"daw"	delete a word				*daw*
	"diW"	delete inner WORD (see |WORD|)		*diW*
	"daW"	delete a WORD (see |WORD|)		*daW*
	"dgn"   delete the next search pattern match    *dgn*
	"dd"	delete one line				|dd|
	"dis"	delete inner sentence			*dis*
	"das"	delete a sentence			*das*
	"dib"	delete inner '(' ')' block		*dib*
	"dab"	delete a '(' ')' block			*dab*
	"dip"	delete inner paragraph			*dip*
	"dap"	delete a paragraph			*dap*
	"diB"	delete inner '{' '}' block		*diB*
	"daB"	delete a '{' '}' block			*daB*

Note the difference between using a movement command and an object.  The
movement command operates from here (cursor position) to where the movement
takes us.  When using an object the whole object is operated upon, no matter
where on the object the cursor is.  For example, compare "dw" and "daw": "dw"
deletes from the cursor position to the start of the next word, "daw" deletes
the word under the cursor and the space after or before it.


Tag blocks						*tag-blocks*

For the "it" and "at" text objects an attempt is done to select blocks between
matching tags for HTML and XML.  But since these are not completely compatible
there are a few restrictions.

The normal method is to select a <tag> until the matching </tag>.  For "at"
the tags are included, for "it" they are excluded.  But when "it" is repeated
the tags will be included (otherwise nothing would change).  Also, "it" used
on a tag block with no contents will select the leading tag.

"<aaa/>" items are skipped.  Case is ignored, also for XML where case does
matter.

In HTML it is possible to have a tag like <br> or <meta ...> without a
matching end tag.  These are ignored.

The text objects are tolerant about mistakes.  Stray end tags are ignored.


