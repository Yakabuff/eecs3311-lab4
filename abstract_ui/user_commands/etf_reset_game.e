note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_RESET_GAME
inherit
	ETF_RESET_GAME_INTERFACE
create
	make
feature -- command
	reset_game
    	do
			-- perform some update on the model state
			if
				model.gamestarted = False
			then
				model.set_error ("Error: Game not yet started")
			else
				model.reset
				model.rem_error
			end

			etf_cmd_container.on_change.notify ([Current])
    	end

end
