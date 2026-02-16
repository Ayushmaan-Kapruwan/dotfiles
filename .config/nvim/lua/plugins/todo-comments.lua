return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	event = "BufRead",
	opts = {
		highlight = {
			after = "fg", -- Highlights the text, not just the keyword
		},
	},
	keys = {
		-- Press <leader>st to see ALL your project's TODOs in Telescope!
		{ "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
	},
}
