return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		require("bufferline").setup({
			options = {
				mode = "buffers",
				separator_style = "thin",
				always_show_bufferline = true,
				show_buffer_close_icons = true,
				show_close_icon = false,
				offsets = {
					{
						filetype = "neo-tree",
						text = "File Explorer",
						text_align = "left",
						separator = true,
					},
				},
			},
		})

		-- NEW NAVIGATION: Minimal and clean
		vim.keymap.set("n", "<C-l>", ":BufferLineCycleNext<CR>", { desc = "Next Tab" })
		vim.keymap.set("n", "<C-h>", ":BufferLineCyclePrev<CR>", { desc = "Previous Tab" })

		-- Close current tab
		vim.keymap.set("n", "<leader>x", ":bdelete<CR>", { desc = "Close Current Tab" })
	end,
}
