-- Bootstrap lazy.nvim using modern 2026 API
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    print("Error cloning lazy.nvim:\n" .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim to import everything from your plugins folder
require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  -- Automatically check for plugin updates
  checker = { enabled = true, notify = false },
  -- Fallback theme during installs
  install = { colorscheme = { "habamax" } },
})
