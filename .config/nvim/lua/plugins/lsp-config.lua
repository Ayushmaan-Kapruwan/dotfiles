--LSP or language server protocol ( used for autofill, errors and suggestions when programming )
--mason to download and  manage LSPs

return {
  {
    "mason-org/mason.nvim",
    opts = {},

    config = function()
      require("mason").setup()
    end
  },

  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},

    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },

    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "omnisharp", "lua_ls", "qmlls" },
        automatic_installation = true,
      })
    end
  },

-- nvim-lspconfig


  {
    "neovim/nvim-lspconfig",

    config = function()

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      
      --configuring the server for omnisharp
      vim.lsp.config("omnisharp", {
        cmd = { "dotnet", "/home/sof/.local/share/nvim/mason/packages/omnisharp/libexec/OmniSharp.dll"},
        enable_editorconfig_support = true,
        enable_roslyn_analyzers = true,
        enable_import_completion = true,
        organize_imports_on_format = true,
        capabilities = vim.lsp.protocol.make_client_capabilities(),
      })

      vim.lsp.enable("omnisharp")

      --lua for neovim config
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = { diagnostics = { globals = { "vim" } } },
        },
      })
      vim.lsp.enable("lua_ls")

      vim.lsp.config("qmlls", {})
      vim.lsp.enable("qmlls")
    end,
  },
}
