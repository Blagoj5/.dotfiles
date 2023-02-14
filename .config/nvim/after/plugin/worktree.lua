function string:split(inSplitPattern, outResults)
	if not outResults then
		outResults = {}
	end
	local theStart = 1
	local theSplitStart, theSplitEnd = string.find(self, inSplitPattern, theStart)
	while theSplitStart do
		table.insert(outResults, string.sub(self, theStart, theSplitStart - 1))
		theStart = theSplitEnd + 1
		theSplitStart, theSplitEnd = string.find(self, inSplitPattern, theStart)
	end
	table.insert(outResults, string.sub(self, theStart))
	return outResults
end

local home = os.getenv("HOME")
local create_worktree = function()
	vim.ui.input({ prompt = "Enter worktree info (feature,branch-name-from):" }, function(input)
		local parsedInfo = {}
		local i = 0
		for word in string.gmatch(input, "([^,]+)") do
			print(word)
			parsedInfo[i] = word
			i = i + 1
		end
		local path = parsedInfo[0]
		local branchName = parsedInfo[1]
		-- Creates a worktree.  Requires the path, branch name, and the upstream
		require("git-worktree").create_worktree(home .. "/code/" .. path, branchName, "origin")
	end)
end

local switch_worktree = function()
	vim.ui.input({ prompt = "Enter worktree info (feature):" }, function(input)
		local parsedInfo = {}
		local i = 0
		for word in string.gmatch(input, "([^,]+)") do
			print(word)
			parsedInfo[i] = word
			i = i + 1
		end
		local path = parsedInfo[0]
		-- switches to an existing worktree.  Requires the path name
		require("git-worktree").switch_worktree(home .. "/code/" .. path)
	end)
end

local delete_worktree = function()
	vim.ui.input({ prompt = "Enter worktree info (feature):" }, function(input)
		local parsedInfo = {}
		local i = 0
		for word in string.gmatch(input, "([^,]+)") do
			print(word)
			parsedInfo[i] = word
			i = i + 1
		end
		local path = parsedInfo[0]
		-- deletes to an existing worktree.  Requires the path name
		require("git-worktree").delete_worktree(home .. "/code/" .. path)
	end)
end

vim.keymap.set("n", "<leader>wc", create_worktree)
vim.keymap.set("n", "<leader>ws", switch_worktree)
vim.keymap.set("n", "<leader>wd", delete_worktree)
