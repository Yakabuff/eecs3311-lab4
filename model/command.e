note
	description: "Summary description for {COMMAND}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	COMMAND

feature--attribute
	access:ETF_MODEL_ACCESS
	row:INTEGER
	col:INTEGER

feature
	make
		do

		end

feature --execute undo redo
execute deferred end
undo deferred end
redo deferred end

end
