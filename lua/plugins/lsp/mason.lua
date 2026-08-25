return {
  {
    "williamboman/mason.nvim",
    version = "^1.0.0",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      -- Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim
      {
        "williamboman/mason-lspconfig.nvim",
        version = "^1.0.0",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
          ensure_installed = {
            "astro",
            "bashls",
            "cssls",
            "html",
            "jsonls",
            "lua_ls",
            "marksman",
            "mdx_analyzer",
            "pyright",
            "tailwindcss",
            "taplo",
            "vtsls",
          },
          automatic_installation = false,
        },
      },

      -- Install and upgrade third party tools automatically
      -- currently only using for installing linters
      {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
          require("mason-tool-installer").setup({
            ensure_installed = {
              "beautysh",
              { "biome", version = "2.1.2" },
              "eslint-lsp",
              "gopls",
              "prettierd",
              "cspell",
            },
            automatic_installation = false,
          })
        end,
      },
    },

    cmd = { "Mason" },
    opts = {
      ui = {
        icons = {
          package_pending = " ",
          package_installed = "󰄳 ",
          package_uninstalled = " 󰚌",
        },

        keymaps = {
          toggle_server_expand = "<CR>",
          install_server = "i",
          update_server = "u",
          check_server_version = "c",
          update_all_servers = "U",
          check_outdated_servers = "C",
          uninstall_server = "X",
          cancel_installation = "<C-c>",
        },

        registries = {
          "lua:mason-registry.index",
          "github:mason-org/mason-registry@2025-11-27-static-profit ",
        },
      },
    },
  },
}
