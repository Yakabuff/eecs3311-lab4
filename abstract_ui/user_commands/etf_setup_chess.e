note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_SETUP_CHESS
inherit
	ETF_SETUP_CHESS_INTERFACE
create
	make
feature -- command
	setup_chess(c: INTEGER_32 ; row: INTEGER_32 ; col: INTEGER_32)
		require else
			setup_chess_precond(c, row, col)

    	do
    					----ERROR CHECKING---
			if
				model.gamestarted = TRUE
			then
				model.set_error ("Error: Game already started")
			elseif
				row > 4 or row < 1 or col > 4 or col < 1
			then
				model.set_error ("Error: (r, c) not a valid slot")
			elseif
				model.board[row,col].out /~ "."
			then
				model.set_error ("Error: (r, c) is taken")

			else
			-- perform some update on the model state
			if c = K then
				model.setup(create {KING}.make(row, col))
				model.rem_error
			elseif
				c=Q
			then
				model.setup(create {QUEEN}.make (row, col))
				model.rem_error
			elseif
				c=N
			then
				model.setup(create {KNIGHT}.make (row, col))
				model.rem_error
			elseif
				c=B
			then
				model.setup(create {BISHOP}.make (row, col))
				model.rem_error
			elseif
				c=R
			then
				model.setup(create {ROOK}.make (row, col))
				model.rem_error
			elseif
				c=P
			then
				model.setup(create {PAWN}.make (row, col))
				model.rem_error
			end

			end

			etf_cmd_container.on_change.notify ([Current])
    	end

end