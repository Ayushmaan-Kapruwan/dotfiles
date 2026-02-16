--treesitter ( Syntax highlighting and indenting for languages )

return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",

	config = function()
		--setups the treesitter plugin for highlighting
		local config = require("nvim-treesitter.configs")

		config.setup({
			ensure_installed = {
				"lua",
				"javascript",
				"bash",
				"c",
				"c_sharp",
				"cpp",
				"python",
				"css",
				"rasi",
				"jsonc",
				"json",
				"kdl",
				"qmljs",
				"hyprlang",
				"vimdoc",
			},
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
