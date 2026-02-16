return {
	"rmagatti/auto-session",
	config = function()
		local auto_session = require("auto-session")

		auto_session.setup({
			log_level = "error",
			auto_session_suppress_dirs = { "~/", "~/Downloads", "/tmp", "/" },

			-- Recommended for Neo-tree users to prevent UI glitches
			pre_save_cmds = { "Neotree close" },

			-- This handles the Telescope integration safely
			session_lens = {
				load_on_setup = true,
				previewer = false,
				theme_conf = { border = true },
			},
		})

		-- Keybinding to search sessions
		vim.keymap.set("n", "<leader>ls", "<cmd>SearchSession<cr>", {
			noremap = true,
			desc = "Search Sessions",
		})
	end,
}
