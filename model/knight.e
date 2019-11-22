note
	description: "Summary description for {KNIGHT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	KNIGHT

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
			type := "N"
		end
	set_pos(r,c:INTEGER)
		do
			row:=r
			col:=c
		end

	moves:ARRAY[TUPLE[r:INTEGER;c:INTEGER]]
		do
			create Result.make_empty

			if
				(col+2)<=4 and (row+1)<=4
			then
				Result.force ([row+1,col+2],Result.upper+1)
			end
			if
				(col+1)<=4 and (row+2)<=4
			then
				Result.force ([row+2,col+1],Result.upper+1)
			end
			if
				(col+2)<=4 and (row-1)>=1
			then
				Result.force ([row-1,col+2],Result.upper+1)
			end
			if
				(col+1)<=4 and (row-2)>=1
			then
				Result.force ([row-2,col+1],Result.upper+1)
			end
			if
				(col-2)>=1 and (row+1)<=4
			then
				Result.force ([row+1,col-2],Result.upper+1)
			end
			if
				(col-1)>=1 and (row+2)<=4
			then
				Result.force ([row+2,col-1],Result.upper+1)
			end
			if
				(col-2)>=1 and (row-1)>=1
			then
				Result.force ([row-1,col-2],Result.upper+1)
			end
			if
				(col-1)>=1 and (row-2)>=1
			then
				Result.force ([row-2,col-1],Result.upper+1)
			end
		end

	blocked(r:INTEGER;c:INTEGER):BOOLEAN
		do
			if --2blocks below
				(r - row) = 2
			then
				Result:= access.m.board[row+1,col] /~ "." or access.m.board[row+2,col] /~ "."
--				if --on the right
--					c > col
--				then
--					Result:= access.m.board[row+1,col] /~ "." or access.m.board[row+2,col] /~ "." or access.m.board[row+2,col+1] /~ "."
--				end
			elseif  --2blocks up
				(row-r) = 2
			then
				Result:= access.m.board[row-1,col] /~ "." or access.m.board[row-2,col] /~ "."
			elseif	--1block below
				(r - row) = 1
			then
				if --down right
					c>col
				then
					Result:= access.m.board[row+1,col] /~ "." or access.m.board[row+1,col+1] /~ "."
				elseif	--down left
					c<col
				then
					Result:= access.m.board[row+1,col] /~ "." or access.m.board[row+1,col-1] /~ "."
				end
			elseif
				(row-r) = 1
			then
				if
					c>col--up right
				then
					Result:= access.m.board[row-1,col] /~ "." or access.m.board[row-1,col+1] /~ "."
				elseif
					c<col--up left
				then
					Result:= access.m.board[row-1,col] /~ "." or access.m.board[row-1,col-1] /~ "."
				end
			end
		end

	out:STRING
		do
			Result:= type
		end

end
