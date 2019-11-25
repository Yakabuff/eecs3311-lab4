note
	description: "Summary description for {COMMAND_MOVES}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	COMMAND_MOVES

inherit
	COMMAND
create
	make
feature
	r1,c1:INTEGER
feature
	make(r,c:INTEGER)
		do
			r1:=r
			c1:=c
		end
feature
	execute
		do
			access.m.moves (r1, c1)
			access.m.rem_error
		end

	undo
		do
			access.m.set_error ("ERROR")
		end

	redo
		do
			access.m.set_error ("ERROR")
		end
end
