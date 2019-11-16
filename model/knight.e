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

--			if
--				row+2
--			then

--			end
--			if

--			then

--			end
--			if

--			then

--			end
--			if

--			then

--			end
--			if

--			then

--			end
--			if

--			then

--			end
--			if

--			then

--			end
--			if

--			then

--			end
		end

	blocked(r:INTEGER;c:INTEGER):BOOLEAN
		do
			Result:=False
		end

	out:STRING
		do
			Result:= type
		end

end
