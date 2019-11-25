note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_START_GAME
inherit
	ETF_START_GAME_INTERFACE
create
	make
feature -- command
	start_game
		local
			st_g:COMMAND_START_GAME
    	do
			-- perform some update on the model state
			if
				model.gamestarted = TRUE
			then
				model.set_error ("Error: Game already started")
			else
				--model.start_game
				create {COMMAND_START_GAME} st_g.make
				st_g.execute
				model.rem_error
			end

			etf_cmd_container.on_change.notify ([Current])
    	end

end
