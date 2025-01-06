--
-- TODO 
-- Redesign marks display
--



if vim.g.loaded_marks then
	return
end
vim.g.loaded_marks = true

local marks = {}
local latest = 0

--function dumpTable(tbl, indent)
--    indent = indent or 0
--    for k, v in pairs(tbl) do
--        print(string.rep(" ", indent) .. tostring(k) .. ":")
--        if type(v) == "table" then
--            dumpTable(v, indent + 2)
--        else
--            print(string.rep(" ", indent + 2) .. tostring(v))
--        end
--    end
--end

local function dumpTable (tbl)
end

vim.api.nvim_create_user_command("AddMark",
	function()

		local line = vim.api.nvim_win_get_cursor(0)

		table.insert(marks, line[1])

		table.sort(marks, function(a, b)
			return a < b
		end)

		latest = line

	end, {}
)

vim.api.nvim_create_user_command("ListMarks",
	function()
	if (marks == nil) then
		print("There are no marks.")
		return
	end

	for _, line in pairs(marks) do
		print(tostring(line))
	end

	print("Latest: " .. unpack(latest))

	end, {}
)

vim.api.nvim_create_user_command("GoToMark",
	function(args)

		if (unpack(marks) == nil) then
			print("There are no marks.")
			return
		end

		local index = args.args

		--dumpTable(args.args)

		if (index == '' or index == nil) then
			vim.api.nvim_win_set_cursor(0, {tonumber(latest[1]), 0})
			--vim.api.nvim_feedkeys('ENTER', 'n', true)
		else
			vim.api.nvim_win_set_cursor(0, {marks[tonumber(index)], 0})
			--vim.api.nvim_feedkeys('ENTER', 'n', true)
		end

	end,
	{ nargs = '?' }
)

vim.api.nvim_create_user_command("ClearMarks",
	function()
		marks = {}
	end,
	{}
)
