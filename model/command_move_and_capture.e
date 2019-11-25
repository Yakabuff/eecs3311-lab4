note
	description: "Summary description for {COMMAND_MOVE_AND_CAPTURE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	COMMAND_MOVE_AND_CAPTURE

inherit
	COMMAND

create
	make
feature

	row1,row2,col1,col2:INTEGER
	p1:PIECE
	p2:PIECE
	wasWon:BOOLEAN
feature
	make(r1,r2,c1,c2:INTEGER)
		do
			row1:=r1
			row2:=r2
			col1:=c1
			col2:=c2
			check attached {PIECE} access.m.board[row1,col1] as p then p1 := p end
			check attached {PIECE} access.m.board[row2,col2] as w then p2 := w end
		end
feature
	execute
		do

			access.m.move_and_capture (row1, col1, row2, col2)
			access.m.history.extend (Current)
			access.m.history.forth
			if
				access.m.gamewon
			then
				wasWon:=TRUE
			end

		end

	undo
		do
			access.m.board.put (p1, row1, col1)
			access.m.board.put (p2, row2, col2)
			access.m.addnumpieces
		end

	redo
		do
			access.m.board[row1,col1] := "."
			access.m.board.put (p1, row2, col2)

			access.m.decnumpieces
				if
					access.m.pieces=1 and access.m.gamestarted=TRUE and not access.m.gamesettingup and access.m.gamewondisplayed = 1
				then
					access.m.undogamewondisplayed
					access.m.setwin
				end
		end

end
