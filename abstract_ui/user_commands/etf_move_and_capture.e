note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_MOVE_AND_CAPTURE
inherit
	ETF_MOVE_AND_CAPTURE_INTERFACE
create
	make
feature -- command
	move_and_capture(r1: INTEGER_32 ; c1: INTEGER_32 ; r2: INTEGER_32 ; c2: INTEGER_32)
		local
			piece:PIECE
			posMoves:ARRAY[TUPLE[r:INTEGER;c:INTEGER]]
    	do
			-- perform some update on the model state

			if
				model.gamestarted=false
			then
				model.set_error("Error: Game not yet started")
			elseif
				model.gamewon=TRUE
			then
				model.set_error("Error: Game already over")
			elseif
				r1=r2 and c1 = c2
			then
				model.set_error("Error: Invalid move of Q from ("+r1.out+", "+ c1.out+") to ("+r2.out+","+ c2.out+")")
			elseif
				r1>4 or r1 <1 or c1 > 4 or c1 < 1
			then
				model.set_error("Error: ("+r1.out + ", " + c1.out+") not a valid slot")
			elseif
				 r2 > 4 or r2 <1 or c2 >4 or c2 < 1
			then
				model.set_error("Error: ("+r2.out + ", " + c2.out+") not a valid slot")
			elseif
				model.board[r1,c1] ~ "."
			then
				model.set_error("Error: Slot @ ("+r1.out+", "+ c1.out+") not occupied")
			elseif
				model.board[r2,c2] ~ "."
			then
				model.set_error("Error: Slot @ ("+r2.out+", "+ c2.out+") not occupied")
			elseif
				--check if valid move
				check_valid(r1,c1,r2,c2) = False
			then
				model.set_error("Error: Invalid move of B from ("+r1.out+", " + r2.out+") to (1, 4)")
			elseif

				check_block(r1,c1,r2,c2)
			then
				model.set_error("Error: Block exists between (4, 3) and (2, 1)")
			else
			model.move_and_capture(r1,c1,r2,c2)
			model.rem_error
			end
			etf_cmd_container.on_change.notify ([Current])
    	end
	check_valid(r1:INTEGER;c1:INTEGER;r2:INTEGER;c2:INTEGER):BOOLEAN
		local
			piece:PIECE
			posMoves:ARRAY[TUPLE[r:INTEGER;c:INTEGER]]
		do
				check attached {PIECE} model.board[r1,c1] as d then piece := d end

				posMoves := piece.moves
				Result:=
				across
					1 |..| posMoves.upper is m
				some
					posMoves[m].r = r2 and posMoves[m].c = c2
				end

		end

	check_block(r1,c1,r2,c2:INTEGER):BOOLEAN
		local
			piece:PIECE
			posMoves:ARRAY[TUPLE[r:INTEGER;c:INTEGER]]
		do
			check attached {PIECE} model.board[r1,c1] as t then piece := t end
			Result:=piece.blocked(r2,c2)
		end
end
