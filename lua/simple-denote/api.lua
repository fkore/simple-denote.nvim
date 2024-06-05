local M = {}

local internal = require("simple-denote.internal")

function M.splitspace(str)
	local chunks = {}
	for substring in str:gmatch("%S+") do
		table.insert(chunks, #chunks, substring)
	end
	return chunks
end

---@param options table
---@param name string|nil
---@param tags table|nil
function M.note(options, name, tags)
	if not name then
		vim.ui.input({ prompt = "Note title: " }, function(input)
			name = input
			if not tags then
				vim.ui.input({ prompt = "Tags: " }, function(input)
					tags = input
					internal.note(options, name, tags)
				end)
			end
		end)
	else
		internal.note(options, name, tags)
	end
end

---@param options table
---@param filename string|nil
---@param new_title string|nil
function M.retitle(options, filename, new_title)
	if not filename then
		filename = vim.fn.expand("%")
	end
	if not new_title then
		vim.ui.input({ prompt = "New title: " }, function(input)
			new_title = input
			internal.retitle(options, filename, new_title)
		end)
	else
		internal.retitle(options, filename, new_title)
	end
end

---@param options table
---@param filename string|nil
---@param new_tags table|nil
function M.retag(options, filename, new_tags)
	if not filename then
		filename = vim.fn.expand("%")
	end
	if not new_tags then
		vim.ui.input({ prompt = "New tags: " }, function(input)
			new_tags = input
			internal.retag(options, filename, new_tags)
		end)
	else
		internal.retag(options, filename, new_tags)
	end
end

return M
