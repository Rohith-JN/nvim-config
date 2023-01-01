function SwitchLine(src_line_idx, direction)
	if direction == "up" then
		if src_line_idx == 1 then
			return
		end
		vim.api.nvim_command("move-2")
	elseif direction == "down" then
		if src_line_idx == vim.api.nvim_call_function("line", "$") then
			return
		end
		vim.api.nvim_command("move+1")
	end
end

function MoveSelection(direction)
	if vim.api.nvim_call_function("visualmode", 0) ~= "V" then
		return
	end
	local start_line = vim.api.nvim_call_function("line", "'<")
	local end_line = vim.api.nvim_call_function("line", "'>")
	local num_line = end_line - start_line + 1
	if direction == "up" then
		if start_line == 1 then
			vim.api.nvim_command("gv")
			return
		end
		vim.api.nvim_command(string.format("%s,%smove-2", start_line, end_line))
		vim.api.nvim_command("gv")
	elseif direction == "down" then
		if end_line == vim.api.nvim_call_function("line", "$") then
			vim.api.nvim_command("gv")
			return
		end
		vim.api.nvim_command(string.format("%s,%smove+%s", start_line, end_line, num_line))
		vim.api.nvim_command("gv")
	end
end

function GoToBuffer(count, direction)
	if count == 0 then
		if direction == "forward" then
			vim.api.nvim_command("bnext")
		elseif direction == "backward" then
			vim.api.nvim_command("bprevious")
		else
			vim.api.nvim_err_writeln("Bad argument " .. direction)
		end
		return
	end

	if vim.tbl_index(GetBufNums(), count) == -1 then
		vim.fn.nvim_notify(string.format("Invalid bufnr: %d", count), 4, { title = "nvim-config" })
		return
	end

	if direction == "forward" then
		vim.api.nvim_command(string.format("buffer%d", count))
	end
end

function GetBufNums()
	local buf_list = {}
	for _, buf in ipairs(vim.api.nvim_get_buf_info({ buflisted = 1 })) do
		buf_list[#buf_list + 1] = buf.bufnr
	end
	return buf_list
end
