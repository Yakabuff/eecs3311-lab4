note
	description: "Summary description for {KING}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ROOK

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
			type := "R"
		end
	moves:ARRAY[TUPLE[r:INTEGER;c:INTEGER]]
	do
		create Result.make_empty

		across -- get value on x
			1 |..| 4  is i
		loop
			if
				i /= col
			then
				Result.force ([row, i], Result.upper + 1)
			end

		end

		across -- get every y
			1 |..| 4  is j
		loop
			if
				j /= row
			then
				Result.force ([j, col], Result.upper + 1)
			end

		end

	end


	blocked(r:INTEGER;c:INTEGER):BOOLEAN
		do

		if
			r > row
		then
			across -- get value on x
				(row+1) |..| (r-1)  is i
			loop
				if
					access.m.board[i,col] /~ "."
				then
					Result:=TRUE
				end

			end
		elseif
			r < row
		then
			across -- get value on x
				(r+1) |..| (row-1)  is i
			loop
				if
					access.m.board[i,col] /~ "."
				then
					Result:=TRUE
				end

			end
		elseif
			c >col
		then
			across -- get value on x
				(col+1) |..| (c-1)  is i
			loop
				if
					access.m.board[row,i] /~ "."
				then
					Result:=TRUE
				end

			end
		elseif
			c < col
		then
			across -- get value on x
				(c+1) |..| (col-1)  is i
			loop
				if
					access.m.board[row,i] /~ "."
				then
					Result:=TRUE
				end

			end
		end
		end
	out:STRING
		do
			Result:= type
		end
	set_pos(r,c:INTEGER)
		do
			row:=r
			col:=c
		end
end
