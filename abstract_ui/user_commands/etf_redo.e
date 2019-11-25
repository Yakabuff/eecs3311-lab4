note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_REDO
inherit
	ETF_REDO_INTERFACE
--		redefine redo end
create
	make
feature -- command
	redo
    	do
			-- perform some update on the model state
			if
				model.history.index =model.history.count
			then
				model.set_error ("Error: Nothing to redo")
			else
				model.redo
				model.rem_error
			end

			etf_cmd_container.on_change.notify ([Current])
    	end

end
