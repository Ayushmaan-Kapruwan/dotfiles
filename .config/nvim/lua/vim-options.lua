vim.g.mapleader = " " --leader key
vim.g.maplocalleader = "\\"

vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>")

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.relativenumber = true --relative line
vim.opt.clipboard = "unnamedplus" --shared clipboard with wayland

vim.diagnostic.config({
	virtual_text = { prefix = "●" },
	underline = true, --adds underline
	signs = false, --remove gutter letters
	update_in_insert = false,
	severity_sort = true,
})
