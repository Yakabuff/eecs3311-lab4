note
	description: "Summary description for {COMMAND_SETUP_GAME}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	COMMAND_SETUP_GAME

inherit
	COMMAND

create
	make
feature--attributes


	piece:PIECE
feature
	make( c:PIECE)
		do

			piece:=c
			row := c.row
			col:= c.col
		end
feature
	execute
		do


			access.m.history.extend (Current)
			access.m.history.forth
			access.m.setup (piece)

			access.m.rem_error
		end

	undo
		do

			access.m.board[row, col] := "."
			access.m.decnumpieces
--			access.m.history.back

		end

	redo
		do

			access.m.board[row, col] := piece
			access.m.addnumpieces
			access.m.rem_error
		end
end
