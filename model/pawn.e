note
	description: "Summary description for {PAWN}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PAWN
inherit
	PIECE
redefine
	make,moves,out
end
create
	make

feature
	make(r:INTEGER; c:INTEGER)
		do
			row:= r
			col := c
			type := "P"
		end
	set_pos(r,c:INTEGER)
		do
			row:=r
			col:=c
		end
	moves:ARRAY[TUPLE[r:INTEGER;c:INTEGER]]
		local
			diag_r:TUPLE[r:INTEGER;c:INTEGER]
			diag_l:TUPLE[r:INTEGER; c:INTEGER]
			up:TUPLE[r:INTEGER;c:INTEGER]
			listMoves:ARRAY[TUPLE[r:INTEGER;c:INTEGER]]
		do
			create listMoves.make_empty

			create diag_r.default_create
			create diag_l.default_create
			create up.default_create

			diag_r.r:= row-1
			diag_r.c := col+1
			diag_l.r := row-1
			diag_l.c:= col-1


			if
				row >1
			then
				if
					col >1
				then

					listMoves.force ([diag_r.r, diag_l.c], listMoves.upper + 1)
				end

				if
					col <4
				then
					listMoves.force ([diag_r.r, diag_r.c], listMoves.upper + 1)
				end


			end



			Result:= listMoves

		end

	blocked(r:INTEGER;c:INTEGER):BOOLEAN
		local
			tmp:ARRAY[TUPLE[r:INTEGER;c:INTEGER]]
			canMove:BOOLEAN
		do
			tmp := moves
			canMove:=True
			if
				row= r and col = c
			then
				canMove:= False and canMove
			end

			if
				c=col+1 and r = row-1 and access.m.board[r,c] /~ '.'
			then
				canMove:= True and canMove
			elseif
				c=col-1 and r = row-1 and access.m.board[r,c] /~ '.'
			then
				canMove:= True and canMove
			else

				canMove:= False and canMove
			end


			Result:=canMove
		end

	out:STRING
		do
			Result:= type
		end
end
