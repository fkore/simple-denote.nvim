local M = {}
local internal = require("denote.internal")
local util = require("denote.util")

function M.note()
	local name = ""
	local tags = nil

	vim.ui.input({ prompt = "Note name: " }, function(input)
		name = input
	end)

	vim.ui.input({ prompt = "Enter tags: " }, function(input)
		if input ~= "" and input then
			tags = splitspace(input)
		end
	end)

	if name == "" then
		error("Didn't specify name")
	end

	internal.note(name, tags)
end

function M.search()
	local date = nil
	local name = nil

	vim.ui.input({ prompt = "Date: " }, function(input)
		local split = util.splitspace(input)
		if split[0] then
			date = {}
			date.year = split[0]
			if split[1] then
				date.month = split[1]
				if split[2] then
					date.day = split[2]
				end
			end
		end
	end)
	vim.ui.input({ prompt = "Name: " }, function(input)
		name = input
	end)

	local status = internal.search(date, name, function(input)
		if input then
			vim.cmd("e " .. internal.config.vault.dir .. "/" .. input)
		end
		if date then
			print(date.year, " ", date.month, " ", date.day)
			print("FSD")
		end
	end)
	-- print(date)
	-- if date then
	-- 	print(date.year, " ", date.month, " ", date.day)
	-- 	print("FSD")
	-- end

	if not status then
		print("Error opening file")
	end
end

---@param config DenoteConfig
function M.setup(config)
	if config then
		internal.config = config
	end
end

return M