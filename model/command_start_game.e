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


			access.m.history.extend (Current)
			access.m.history.forth
			access.m.start_game
			access.m.rem_error
			access.m.history.go_i_th (access.m.history.count)
		end

	undo
		do
			access.m.unstart_game
			if
				access.m.gamewon
			then
				access.m.unsetwin
			elseif
				access.m.gameloss
			then
				access.m.unsetloss
			end

			access.m.rem_error
		end

	redo
		do
			access.m.start_game
			access.m.rem_error
		end
end
