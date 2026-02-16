-- Telescope (Search for files in current directory and specific words in current file)

return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = { "nvim-lua/plenary.nvim" },

	config = function()
		--setups the telescope plugin
		local builtin = require("telescope.builtin")
		require("telescope").setup({
			defaults = {
				mappings = {
					i = {
						["<C-j>"] = "move_selection_next",
						["<C-k>"] = "move_selection_previous",
					},
				},
				file_ignore_patterns = { "node_modules", ".git/", "bin/", "obj/" },
			},
		})

		--setups Telescope file search keybind to Ctrl + p
		vim.keymap.set("n", "<C-f>", builtin.find_files, {})

		--setups Telescope word search keybind to Space 'f' 'g'
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
	end,
}
