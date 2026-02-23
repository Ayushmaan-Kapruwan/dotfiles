return {
	"goolord/alpha-nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		-- The theme functions are initialized

		dashboard.config.layout = {
			{ type = "padding", val = 3 },
			dashboard.section.header,
			{ type = "padding", val = 2 },
			dashboard.section.buttons,
			{ type = "padding", val = 1 },
			dashboard.section.footer,
		}

		-- Header

		dashboard.section.header.val = {
			[[                               __                ]],
			[[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
			[[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
			[[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
			[[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
			[[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
		}

		vim.api.nvim_set_hl(0, "AlphaHeaderBold", { fg = "#f9e2af", bold = true })
		dashboard.section.header.opts.hl = "AlphaHeaderBold"

		-- Buttons
		dashboard.section.buttons.val = {
			dashboard.button("e", "  New file", ":ene <BAR> startinsert<CR>"),
			dashboard.button("Ctrl + Space", "󰥨  Fuzzy Find", ":Telescope find_files<CR>"),
			dashboard.button("Ctrl + Shift + Space", "󰱼  Fuzzy Grep", ":Telescope live_grep<CR>"),
			dashboard.button("Ctrl + E", "  Neotree", ":Telescope oldfiles<CR>"),
			dashboard.button(" Leader st", "󰨽 Find Comments", "<cmd>TodoTelescope<CR>"),
			dashboard.button("Leader l", "󰒲 Lazy Vim", "<cmd>Lazy<CR>"),
			dashboard.button("q", "󰩈  Quit", ":qa<CR>"),
		}

		-- Footer
		dashboard.section.footer.val = { "  Neovim loaded successfully" }

		alpha.setup(dashboard.config)
	end,
}
