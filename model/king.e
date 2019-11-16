note
	description: "Summary description for {KING}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	KING

inherit
	PIECE
redefine
	make,moves,out
end
create
	make

feature
	
	set_pos(r,c:INTEGER)
		do
			row:=r
			col:=c
		end

	make(r:INTEGER; c:INTEGER)
		do
			row:= r
			col := c
			type := "K"
		end
	moves:ARRAY[TUPLE[r:INTEGER;c:INTEGER]]
	do
		create Result.make_empty

		if
		(row+1) < 4
		then
			Result.force ([row+1, col], (Result.upper+1))
			if
				(col-1) >= 0
			then
				Result.force ([row+1, col-1], (Result.upper+1))
			end

			if
				col+1< 4
			then
				Result.force ([row+1, col+1], (Result.upper+1))
			end
		end

		if
			(row-1) >= 1
		then
			Result.force ([row-1, col], (Result.upper+1))
			if
				col-1 >= 0
			then
				Result.force ([row-1, col-1], (Result.upper+1))
			end

			if
				(col + 1) < 4
			then
				Result.force ([row-1, col+1], (Result.upper+1))
			end
		end

		if
			(col-1) >= 1
		then
			Result.force ([row, col-1], (Result.upper+1))
		end

		if
			col + 1 < 4
		then
			Result.force ([row, col+1], (Result.upper+1))
		end
	end

	blocked(r:INTEGER;c:INTEGER):BOOLEAN
		local
			tmp:ARRAY[TUPLE[r:INTEGER;c:INTEGER]]
			canMove:BOOLEAN
		do
			tmp := moves
			canMove := TRUE
--			if
--				row= r and col = c
--			then
--				canMove:= False and canMove
--			end

--			if
--				c=col and r = row+1 and access.m.board[r,c] /~ '.'
--			then
--				canMove:= True and canMove
--			elseif
--				c=col and r = row-1 and access.m.board[r,c] /~ '.'
--			then
--				canMove:= True and canMove
--			elseif
--				c=col+1 and r = row and access.m.board[r,c] /~ '.'
--			then
--				canMove:= True and canMove
--			elseif
--				c=col-1 and r = row and access.m.board[r,c] /~ '.'
--			then
--				canMove:= True and canMove
--			elseif
--				c=col+1 and r = row-1 and access.m.board[r,c] /~ '.'
--			then
--				canMove:= True and canMove
--			elseif
--				c=col+1 and r = row+1 and access.m.board[r,c] /~ '.'
--			then
--				canMove:= True and canMove
--			elseif
--				c=col-1 and r = row-1 and access.m.board[r,c] /~ '.'
--			then
--				canMove:= True and canMove
--			elseif
--				c=col-1 and r = row+1 and access.m.board[r,c] /~ '.'
--			then
--				canMove:= True and canMove
--			else
--				canMove:= False and canMove
--			end

			Result := TRUE
		end
	out:STRING
		do
			Result:= type
		end
end
