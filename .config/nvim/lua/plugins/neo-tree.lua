return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	-- Use 'opts' only or pass 'opts' into 'config'. This is the modern way:
	opts = {
		close_if_last_window = true, -- Auto-close if it's the only window left
		window = {
			width = 25, -- 25 is a sweet spot for Kitty on Hyprland
			mapping_options = {
				noremap = true,
				nowait = true,
			},
		},
		filesystem = {
			follow_current_file = { enabled = true },
			filtered_items = {
				hide_dotfiles = false,
				hide_gitignored = false,
			},
			use_libuv_file_watcher = true, -- Better performance on Linux/Eos
		},
		event_handlers = {
			{
				event = "file_opened",
				handler = function()
					-- This handles the "Auto-close on open" behavior you wanted
					require("neo-tree.command").execute({ action = "close" })
				end,
			},
		},
	},
	config = function(_, opts)
		-- You MUST pass 'opts' here for the table above to work!
		require("neo-tree").setup(opts)
		-- Keymap
		vim.keymap.set("n", "<C-n>", ":Neotree toggle filesystem left<CR>", { desc = "Toggle Neo-tree" })
	end,
}
