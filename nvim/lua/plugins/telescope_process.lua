local telescope_config = require("telescope.config").values
local telescope_actions = require("telescope.actions")
local telescope_actions_state = require("telescope.actions.state")
local telescope_finders = require("telescope.finders")
local telescope_pickers = require("telescope.pickers")
local telescope_previewers = require("telescope.previewers")
local telescope_previewers_utils = require("telescope.previewers.utils")
local log = require("plenary.log").new({
	plugin = "telescope_docker",
	level = "info",
})

local M = {}

local run_command = function(command)
	local handle = io.popen(command)
	if not handle then
		log.info("Error running command: " .. command)
		return ""
	end
	local output = handle:read("*a") -- Read the full output as a string
	handle:close()
	return output
end

local parse_process_info = function(process_info)
	local field_map = {
		{ 1, "command" },
		{ 2, "pid" },
		{ 4, "fd" },
		{ 8, "protocol" },
		{ 9, "url" },
	}
	local process = {}

	for _, pair in ipairs(field_map) do
		process[pair[2]] = process_info[pair[1]]
		if not process[pair[2]] then
			return nil
		end
	end

	process.port = process.url:match(".*:(%d+)")
	if not process.port then
		return nil
	end

	process.name = process.command .. ":" .. process.port
	return process
end

local parse_lsof_output = function(result)
	local processes = {}
	for line in result:gmatch("[^\r\n]+") do
		local process_info = {}
		for word in line:gmatch("%S+") do
			table.insert(process_info, word)
		end
		local process = parse_process_info(process_info)
		if process then
			table.insert(processes, parse_process_info(process_info))
		end
	end
	return processes
end

local get_processes = function(command)
	log.info("Running command")
	local result = run_command(command or "lsof -Pn | grep LISTEN")
	log.info("Parsing command result")
	return parse_lsof_output(result)
end

local list_processes = function(opts)
	local processes = get_processes("lsof -Pn | grep LISTEN")
	if vim.tbl_isempty(processes) then
		log.info("No processes found")
		return
	end
	log.info("Listing processes")
	return telescope_pickers
		.new(opts, {
			prompt_title = "Processes",
			finder = telescope_finders.new_table({
				results = processes,
				entry_maker = function(process)
					return {
						value = process,
						display = process.name,
						ordinal = process.name,
					}
				end,
			}),
			sorter = telescope_config.generic_sorter(opts),
			previewer = telescope_previewers.new_buffer_previewer({
				prompt_title = "Process detail",
				define_preview = function(self, entry)
					local process = entry.value
					local formatted = {
						"*COMMAND*: " .. process.command,
						"*PID*: " .. process.pid,
						"*PORT*: " .. process.port,
						"*URL*: " .. process.url,
						"*PROTOCOL*: " .. process.protocol,
						"*FD*: " .. process.fd,
					}
					vim.api.nvim_buf_set_lines(self.state.bufnr, 0, 0, true, formatted)
					telescope_previewers_utils.highlighter(self.state.bufnr, "markdown")
				end,
			}),
			attach_mappings = function(prompt_bufnr)
				telescope_actions.select_default:replace(function()
					local entry = telescope_actions_state.get_selected_entry()
					local process = entry and entry.value
					if not process then
						telescope_previewers_utils.__warn_no_selection("builtin.help_tags")
						return
					end
					local confirm = vim.fn.input(
						"Are you sure you want to terminate the process on port " .. process.port .. "? (y/n): "
					)
					if confirm:lower() == "y" then
						run_command("kill -9 " .. process.pid)
						log.info("Terminating port " .. process.port)
					else
						log.info("Termination aborted.")
					end
					telescope_actions.close(prompt_bufnr)
				end)
				return true
			end,
		})
		:find()
end

M.list_processes = list_processes

return M
