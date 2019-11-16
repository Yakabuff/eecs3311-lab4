note
	description: "Summary description for {BISHOP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BISHOP

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
			type := "B"
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
					isblocked := access.m.board[j,i]/~"."
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
					isblocked := access.m.board[j,i]/~"."
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
					isblocked := access.m.board[j,i]/~"."
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
					isblocked := access.m.board[j,i]/~"."
					i:=i+1
					j:=j+1
				end
			end
		Result:=isblocked
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
