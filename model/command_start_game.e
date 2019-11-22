note
	description: "Summary description for {COMMAND_START_GAME}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	COMMAND_START_GAME

inherit
	COMMAND
create
	make
feature
	gameStarted:BOOLEAN
feature
	make
		do
			gameStarted:= access.m.gamestarted
		end
feature
	execute
		do
			access.m.start_game
		end

	undo
		do

		end

	redo
		do

		end
end
