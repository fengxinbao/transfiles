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

						*linewise* *characterwise*
The operator either affects whole lines, or the characters between the start
and end position.  Generally, motions that move between lines affect lines
(are linewise), and motions that move within a line affect characters (are
characterwise).  However, there are some exceptions.

						*exclusive* *inclusive*
A character motion is either inclusive or exclusive.  When inclusive, the
start and end position of the motion are included in the operation.  When
exclusive, the last character towards the end of the buffer is not included.
Linewise motions always include the start and end position.

Which motions are linewise, inclusive or exclusive is mentioned with the
command.  There are however, two general exceptions:
1. If the motion is exclusive and the end of the motion is in column 1, the
   end of the motion is moved to the end of the previous line and the motion
   becomes inclusive.  Example: "}" moves to the first line after a paragraph,
   but "d}" will not include that line.
						*exclusive-linewise*
2. If the motion is exclusive, the end of the motion is in column 1 and the
   start of the motion was at or before the first non-blank in the line, the
   motion becomes linewise.  Example: If a paragraph begins with some blanks
   and you do "d}" while standing on the first non-blank, all the lines of
   the paragraph are deleted, including the blanks.  If you do a put now, the
   deleted lines will be inserted below the cursor position.

Note that when the operator is pending (the operator command is typed, but the
motion isn't yet), a special set of mappings can be used.  See |:omap|.

Instead of first giving the operator and then a motion you can use Visual
mode: mark the start of the text with "v", move the cursor to the end of the
text that is to be affected and then hit the operator.  The text between the
start and the cursor position is highlighted, so you can see what text will
be operated upon.  This allows much more freedom, but requires more key
strokes and has limited redo functionality.  See the chapter on Visual mode
|Visual-mode|.

You can use a ":" command for a motion.  For example "d:call FindEnd()".
But this can't be repeated with "." if the command is more than one line.
This can be repeated: >
	d:call search("f")<CR>
This cannot be repeated: >
	d:if 1<CR>
	   call search("f")<CR>
	endif<CR>
Note that when using ":" any motion becomes characterwise exclusive.


FORCING A MOTION TO BE LINEWISE, CHARACTERWISE OR BLOCKWISE

When a motion is not of the type you would like to use, you can force another
type by using "v", "V" or CTRL-V just after the operator.
Example: >
	dj
deletes two lines >
	dvj
deletes from the cursor position until the character below the cursor >
	d<C-V>j
deletes the character under the cursor and the character below the cursor. >

Be careful with forcing a linewise movement to be used characterwise or
blockwise, the column may not always be defined.

							*o_v*
v		When used after an operator, before the motion command: Force
		the operator to work characterwise, also when the motion is
		linewise.  If the motion was linewise, it will become
		|exclusive|.
		If the motion already was characterwise, toggle
		inclusive/exclusive.  This can be used to make an exclusive
		motion inclusive and an inclusive motion exclusive.

							*o_V*
V		When used after an operator, before the motion command: Force
		the operator to work linewise, also when the motion is
		characterwise.

							*o_CTRL-V*
CTRL-V		When used after an operator, before the motion command: Force
		the operator to work blockwise.  This works like Visual block
		mode selection, with the corners defined by the cursor
		position before and after the motion.


