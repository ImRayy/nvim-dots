return {
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local mason_lspconfig = require("mason-lspconfig")

      mason_lspconfig.setup_handlers({
        -- default handler for installed servers
        function(server_name)
          vim.lsp.enable(server_name)
        end,
      })

      -- Disables warning "undefined global 'vim'"
      vim.lsp.config.lua_ls = {
        cmd = { "lua-language-server" },
        root_markers = {
          ".luarc.json",
          ".luarc.jsonc",
          ".luacheckrc",
          ".stylua.toml",
          "stylua.toml",
          "selene.toml",
          "selene.yml",
          ".git",
        },
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      }

      vim.lsp.config.eslint = {
        capabilities = capabilities,
        code_actions = {
          enable = true,
          types = { "directive", "problem", "suggestion", "layout" },
        },
        diagnostics = {
          enable = true,
          report_unused_disable_directives = false,
          run_on = "type",
        },
        settings = {
          workingDirectories = { mode = "auto" },
          packageManager = "bun",
        },
      }

      vim.lsp.config.vtsls = {
        capabilities = capabilities,
        enableMoveToFileCodeAction = true,
        autoUseWorkspaceTsdk = true,
        experimental = {
          completion = {
            enableServerSideFuzzyMatch = true,
          },
        },
      }

      vim.lsp.config.qmlls = {
        capabilities = capabilities,
      }

      vim.lsp.config.astro = {
        capabilities = capabilities,
      }

      vim.lsp.config.nixd = {
        cmd = { "nixd" },
        capabilities = capabilities,
        settings = {
          nixd = {
            nixpkgs = {
              expr = "import <nixpkgs> {}",
            },
            options = {
              nixos = {
                expr = '(builtins.getFlake ("git+file://" + toString ./.)).nixosConfigurations.default.options',
              },
              home_manager = {
                expr = '(builtins.getFlake ("git+file://" + toString ./.)).homeConfigurations.ray.options',
              },
            },
          },
        },
      }

      -- Enable all configured servers
      vim.lsp.enable({ "lua_ls", "eslint", "vtsls", "qmlls", "astro", "nixd" })
    end,
  },

  -- Better built-in LSP experience
  {
    "nvimdev/lspsaga.nvim",
    enabled = false,
    event = "LspAttach",
    keys = {
      { "<a-.>", mode = { "n" }, ":Lspsaga ", desc = "Too lazy to type :Lspsaga manually" },
      { "<a-n>", mode = { "n" }, "<cmd>Lspsaga diagnostic_jump_next<cr>", desc = "Jumpt to next diagnostic" },
      { "<a-p>", mode = { "n" }, "<cmd>Lspsaga diagnostic_jump_prev<cr>", desc = "Jumpt to prev diagnostic" },
      { "<leader>ca", mode = { "n" }, "<cmd>Lspsaga code_action<cr>", desc = "Code action" },
    },
    config = function()
      require("lspsaga").setup({
        symbol_in_winbar = {
          enable = false,
        },
        ui = {
          expand = "",
          collapse = "",
          actionfix = "",
          imp_sign = "",
          diagnostic = "🐞",
        },
        lightbulb = {
          enable = true,
          sign = false,
        },
      })
    end,

    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
}
