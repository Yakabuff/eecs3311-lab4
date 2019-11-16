note
	description: "A default business model."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_MODEL

inherit
	ANY
		redefine
			out
		end

create {ETF_MODEL_ACCESS}
	make

feature {NONE} -- Initialization
	make
			-- Initialization for `Current'.
		do
			create s.make_empty
			create error.make_empty
			i := 0
			create board.make_filled (".",4, 4)
			create movesBoard.make_filled (".", 4, 4)
			gameStarted := False
			checkingMoves:=False
			pieces:=0
		end

feature -- model attributes
	s : STRING
	i : INTEGER
	board:ARRAY2[ANY]
	checkingMoves:BOOLEAN
	movesBoard:ARRAY2[ANY]
	gameStarted:BOOLEAN
	pieces:INTEGER
	error:STRING
	gamewon:BOOLEAN
	gameloss:BOOLEAN
feature -- model operations
	default_update
			-- Perform update to the model state.
		do
			i := i + 1
		end

	reset
			-- Reset model state.
		do
			board.make_filled (".", 4, 4)
			movesBoard.make_filled (".", 4, 4)
			gamewon:=FALSE
			gameloss:=FALSE
			gameStarted:=FALSE
		end

	moves(row: INTEGER_32 ; col: INTEGER_32)
		local
			piece:PIECE
			posMoves:ARRAY[TUPLE[r:INTEGER;c:INTEGER]]
		do

			--find piece at coords
			-- determine type
			--determine all possible moves
			checkingMoves := True
			create movesBoard.make_filled (".", 4, 4)

			check attached {PIECE} board[row,col] as p then piece := p end

			posMoves := piece.moves

			across
				1 |..| posMoves.upper is j
			loop
				movesBoard.put ("+",posMoves[j].r,posMoves[j].c)

			end
			movesBoard.put (piece.type,row,col)
			posMoves.make_empty
		end

		setup(c: PIECE )
			do


				board.put (c,c.row, c.col)
				pieces := pieces + 1

			end

		set_error(err:STRING)
			do
				error := err
			end

		rem_error
			do
				error:= ""
			end

		move_and_capture(r1,c1,r2,c2:INTEGER)
			local
				piece:PIECE
			do
				check attached {PIECE} board[r1,c1] as p then piece := p end

				board[r2,c2] := piece


				board[piece.row,piece.col] := "."
				piece.set_pos (r2, c2)
				pieces := pieces -1
				if
					pieces=1
				then
					gamewon:=TRUE
				end

				if
					check_loss = TRUE
				then
					gameloss:=TRUE
				end
			end
		check_loss:BOOLEAN
			local
				piece:PIECE
				loss:BOOLEAN
			do

				across
					board as v
				loop
					if
						v.item.out /~ "."
					then
						check attached {PIECE} v as p then piece := p end
						if
							piece.moves.count = 0
						then
							Result:= TRUE
						end
					end

				end
			end
		start_game
			do
				gamestarted :=TRUE
				if
					pieces=1
				then
					gamewon:=TRUE
				end
			end
feature -- queries
	out : STRING
		do
			create Result.make_from_string ("  ")
			Result.append ("%N")


			if
				checkingMoves=False
			then
				across
				1 |..| board.height is k
			loop
				Result.append("  ")
				across
					1 |..| board.width is j
				loop

					Result.append(board[k,j].out)

				end
				if
					k<4
				then
					Result.append ("%N")
				end

			end
				if
					gamewon
				then
					Result.append ("Game won")
				elseif
					gameloss
				then
					Result.append ("Game lost")
				end
			else
				across
					1 |..| movesboard.height is k
				loop
					Result.append("  ")
					across
						1 |..| movesboard.width is j
					loop

						Result.append(movesboard[k,j].out)

					end
				if
					k<4
				then
					Result.append ("%N")
				end
				checkingMoves:=False

			end

			end



			if
				not error.is_empty
			then
				Result.append(error)
			end

		end

end




