note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_UNDO
inherit
	ETF_UNDO_INTERFACE
--		redefine undo end
create
	make
feature -- command
	undo
    	do
			-- perform some update on the model state
			if
				model.history.index< 1 or model.pieces = 0 and not model.gamestarted
			then
				model.set_error ("Error: Nothing to undo")
			else
				model.undo
				model.rem_error
			end

			etf_cmd_container.on_change.notify ([Current])
    	end

end
