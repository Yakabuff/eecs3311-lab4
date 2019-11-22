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
		end
feature
	execute
		do
			access.m.setup (piece)

			access.m.history.extend (Current)
			access.m.history.forth
		end

	undo
		do
			access.m.board.put (".",piece.row, piece.col)
			access.m.decnumpieces

		end

	redo
		do
			execute
		end
end
