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
			gameSettingUp:=TRUE
			gameloss:=FALSE
			gamewondisplayed :=0
			pieces:=0
			create history.make
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
	gamewondisplayed:INTEGER
	gameloss:BOOLEAN
	gameSettingUp:BOOLEAN
	history:LINKED_LIST[COMMAND]
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
			gamewondisplayed := 0
			gameSettingUp:=TRUE
			pieces:=0
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
					check_loss = TRUE and pieces > 1
				then
					gameloss:=TRUE
				end
			end

		find_pieces:ARRAY[PIECE]
			local
				availPiece:ARRAY[PIECE]
				piece:PIECE
			do
				create availPiece.make_empty
				across
					1 |..| board.height is k
				loop
					across
						1 |..| board.width	 is j
					loop
						if
							board[k,j] /~ "."
						then
							check attached {PIECE} board[k,j] as p then piece := p end
							availPiece.force (piece, availPiece.count+1)
						end

					end
				end
				Result := availPiece
			end

		check_loss:BOOLEAN
			--get all pieces on board
			--check each spot on board and check each possible move for that piece for a "." (each square is not a move for the piece)
			local
				piece:PIECE
				loss:BOOLEAN
				availPiece:ARRAY[PIECE]
				posMoves:ARRAY[TUPLE[r:INTEGER;c:INTEGER]]

			do
				availPiece := find_pieces

				if
					across
						1 |..| availPiece.upper is currPiece
					all

						across
							1 |..| availPiece[currPiece].moves.upper is t
						all
							board[availPiece[currPiece].moves[t].r, availPiece[currPiece].moves[t].c] ~ "." or availPiece[currPiece].blocked(availPiece[currPiece].moves[t].r,availPiece[currPiece].moves[t].c)
						end
					end
				then
					loss:=True
--				else
--					loss:=
--					across
--						1 |..| availPiece.upper is currPiece
--					all


--						across
--							1 |..| availPiece[currPiece].moves.upper is t
--						all

--							availPiece[currPiece].blocked(availPiece[currPiece].moves[t].r,availPiece[currPiece].moves[t].c)
--						end
--					end

				end

				Result:=loss
			end


		start_game
			do
				gameSettingUp:=FALSE
				gamestarted :=TRUE
				if
					pieces=1
				then
					gamewon:=TRUE
				end
--				gameloss := check_loss
			end
		undo
			do

			end

		redo
			do

			end
feature -- queries
	out : STRING
		do
			create Result.make_from_string ("  ")
			Result.append ("# of chess pieces on board: ")
			Result.append (pieces.out)
			Result.append ("%N")


			if
				checkingMoves=False
			then

				Result.append("  ")
				if
					not error.is_empty
				then
					Result.append(error)
				elseif
					gamewon and gamewondisplayed = 0
				then
					Result.append ("Game Over: You Win!")
					gamewondisplayed := 1
				elseif
					gameloss
				then
					Result.append ("Game Over: You Lose!")

				elseif
					gameSettingUp
				then
					Result.append("Game being Setup...")
				elseif
					gamestarted
				then
					Result.append("Game In Progress...")
				end

				Result.append ("%N")

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

			else
				Result.append("  ")
				if
				not error.is_empty
				then
				Result.append(error)
				elseif
					gamestarted
				then
					Result.append("Game In Progress...")
				elseif
					gamewon and gamewondisplayed = 0
				then
					Result.append ("Game won")
					gamewondisplayed := 1
				elseif
					gameloss
				then
					Result.append ("Game lost")
				end
				Result.append ("%N")
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



--			if
--				check_loss = TRUE
--			then
--				Result.append("GAME LOSS")

--			end

		end

end




