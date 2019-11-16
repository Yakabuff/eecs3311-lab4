note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_MOVES
inherit
	ETF_MOVES_INTERFACE
create
	make
feature -- command
	moves(row: INTEGER_32 ; col: INTEGER_32)
    	do
			-- perform some update on the model state

			if
				model.gamestarted=False
			then
				model.set_error ("Error: Game not yet started")
			elseif
				model.gamewon=TRUE or model.gameloss=TRUE
			then
				model.set_error ("Error: game already over")
			elseif
				row>4 or row<1 or col>4 or col<1
			then
				model.set_error ("Error:  not a valid slot")
			elseif
				model.board[row,col].out ~ "."
			then
				model.set_error ("Error: slot  not occupied")
			else
				model.moves (row,col)
				model.rem_error
			end

			etf_cmd_container.on_change.notify ([Current])
    	end

end
