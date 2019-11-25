note
	description: "Summary description for {COMMAND_RESET_GAME}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	COMMAND_RESET_GAME

inherit
	COMMAND
create
	make
feature

feature
	make
		do

		end
feature
	execute
		do
			access.m.reset
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
