note
	description: "Summary description for {QUEEN}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QUEEN

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
			type := "Q"
		end
	set_pos(r,c:INTEGER)
		do
			row:=r
			col:=c
		end
	moves:ARRAY[TUPLE[r:INTEGER;c:INTEGER]]

			local

				i:INTEGER
				j:INTEGER
			do

				create Result.make_empty
		-----------------------------------------------	Up Right
				from
					i := col+1
					 j:=row-1
				until
					i=5 or j=0
				loop
					Result.force ([j, i], Result.upper + 1)
					i:=i+1
					j:=j-1


				end
		-----------------------------------------------	Down right	
				from
				i:= col+1
				j := row+1
				until
				i=5 or j=5
				loop
				Result.force ([j, i], Result.upper + 1)
				i:=i+1
				j:=j+1
				end
		-------------------------------------------------	Up LEft		
				from
				i:= col-1
				j := row-1
				until
				i=0 or j=0
				loop
				Result.force ([j, i], Result.upper + 1)
				j:=j-1
				i:=i-1
				end
		-------------------------------------------------	Down Left		
				from
					i:= col-1
					j := row+1
				until
					j = 5 or i = 0
				loop
					Result.force ([j, i], Result.upper + 1)
					j := j+1
					i := i-1

				end
		-----------------------------------------------	
		across -- get every col
			1 |..| 4  is k
		loop
			if
				k /= col
			then
				Result.force ([row, k], Result.upper + 1)
			end

		end

		across -- get every row
			1 |..| 4  is t
		loop
			if
				t /= row
			then
				Result.force ([t, col], Result.upper + 1)
			end

		end


		end

	blocked(r:INTEGER;c:INTEGER):BOOLEAN

		local
			isblocked:BOOLEAN
			i:INTEGER
			j:INTEGER
		do
			isblocked:= FALSE

			if   --up left
				row > r and col > c
			then
				from
					i := col-1
					 j:=row-1
				until
					i=r+1 or j=c+1 or isblocked=TRUE
				loop
					Result := access.m.board[j,i]/~"."
					i:=i+1
					j:=j-1


				end
			elseif  --up right
				row > r and col < c
			then
				from
					i := col+1
					 j:=row-1
				until
					i=4 or j=0 or isblocked=TRUE
				loop
					Result := access.m.board[j,i]/~"."
					i:=i+1
					j:=j-1
				end
			elseif	--down left
				row < r and col > c
			then
				from
					i := col-1
					 j:=row+1
				until
					i=4 or j=0 or isblocked=TRUE
				loop
					Result := access.m.board[j,i]/~"."
					i:=i+1
					j:=j-1
				end
			elseif --down right
				row < r and col < c
			then
				from
					i := col+1
					 j:=row+1
				until
					i=4 or j=4 or isblocked=TRUE
				loop
					Result := access.m.board[j,i]/~"."
					i:=i+1
					j:=j+1
				end



			elseif
				r > row
			then
				across -- get value on x
					(row+1) |..| (r-1)  is a
				loop
					if
						access.m.board[a,col] /~ "."
					then
						Result:=TRUE
					end

				end
			elseif
				r < row
			then
				across -- get value on x
					(r+1) |..| (row-1)  is a
				loop
					if
						access.m.board[a,col] /~ "."
					then
						Result:=TRUE
					end

				end
			elseif
				c >col
			then
				across -- get value on x
					(col+1) |..| (c-1)  is a
				loop
					if
						access.m.board[row,a] /~ "."
					then
						Result:=TRUE
					end

				end
			elseif
				c < col
			then
				across -- get value on x
					(c+1) |..| (col-1)  is a
				loop
					if
						access.m.board[row,a] /~ "."
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
end
