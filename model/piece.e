note
	description: "Summary description for {PIECE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PIECE
inherit
	ANY
	redefine
	out
end
--create
--	make

feature
	row:INTEGER
	col:INTEGER
	type:STRING
	access: ETF_MODEL_ACCESS

feature
--	move(row:INTEGER, col:INTEGER)
--		do

--		end

	make(r:INTEGER; c:INTEGER)
		do
--			row := r
--			col := c
--			type := t
		end

	moves:ARRAY[TUPLE[r:INTEGER;c:INTEGER]]
		do
--			Result:= create ARRAY[TUPLE[INTEGER]]
		create Result.make_empty
		end

	blocked(r:INTEGER;c:INTEGER):BOOLEAN
		deferred
		end
	out:STRING
		do
			Result:= type
		end
	set_pos(r,c:INTEGER)
		deferred end

	valid_move(r,c:INTEGER):BOOLEAN
		local
			posMoves:ARRAY[TUPLE[r:INTEGER;c:INTEGER]]
		do
			posMoves := moves
			Result:= across
				1 |..| posMoves.upper is curr
			some
				posMoves[curr].r = r and posMoves[curr].c = c
			end
		end

end
