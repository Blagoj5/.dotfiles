require("render-markdown").setup({
	heading = {
		-- icons = { "①  ", "②  ", "③  ", "④  ", "⑤  ", "⑥  " },
		icons = { "① ", "②  ", "③  ", "④  ", "⑤  ", "⑥  " },
		signs = { "▶ " },
	},
	checkbox = {
		-- Turn on / off checkbox state rendering
		enabled = true,
		unchecked = {
			-- Replaces '[ ]' of 'task_list_marker_unchecked'
			icon = "[ ] ",
			-- Highlight for the unchecked icon
			highlight = "RenderMarkdownUnchecked",
		},
		checked = {
			icon = "[✔] ",
			-- Highligh for the checked icon
			highlight = "RenderMarkdownChecked",
		},
	},
	bullet = {
		-- Turn on / off list bullet rendering
		enabled = true,
		-- Replaces '-'|'+'|'*' of 'list_item'
		-- How deeply nested the list is determines the 'level'
		-- The 'level' is used to index into the array using a cycle
		-- If the item is a 'checkbox' a conceal is used to hide the bullet instead
		icons = { "•", "◦", "⁃", "⁃" },
		-- Padding to add to the right of bullet point
		right_pad = 0,
		-- Highlight for the bullet icon
		highlight = "RenderMarkdownBullet",
	},
})
