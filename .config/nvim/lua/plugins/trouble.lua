return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	cmd = "Trouble", -- Lazy loads only when you call it
	keys = {
		{
			"<leader>xx",
			"<cmd>Trouble diagnostics toggle<cr>",
			desc = "Diagnostics (Trouble)",
		},
		{
			"<leader>xX",
			"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
			desc = "Buffer Diagnostics (Trouble)",
		},
	},
	opts = {
		modes = {
			diagnostics = {
				auto_open = false, -- Won't pop up and annoy you
				auto_close = true, -- Closes when errors are fixed
			},
		},
	},
}
