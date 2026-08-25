local function is_format_enabled(bufnr)
  if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
    return
  end
end

local function find_root_file(filenames, start_path)
  return vim.fs.find(filenames, { path = start_path, upward = true })[1]
end

local slow_format_filetypes = { "typescript", "typescriptreact", "javascriptreact" }

return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  cmd = "ConfirmInfo",
  opts = {
    formatters = {
      sql_formatter = {
        prepend_args = {
          "--config",
          '{"expressionWidth": "50", "keywordCase":"upper","dataTypeCase":"upper","functionCase":"upper"}',
        },
      },
      biome = {
        inherit = false,
        command = "biome",
        args = {
          "check",
          "--formatter-enabled=true",
          "--linter-enabled=true",
          -- "--organize-imports-enabled=true",
          "--write",
          -- "--unsafe",
          "--no-errors-on-unmatched",
          "$FILENAME",
        },
        taplo = {
          command = "taplo",
        -- stylua: ignore
        args = {
          "fmt",
          "--option", "align_entries=true",
          "--option", "align_comments=true",
          "--option", "reorder_keys=true",
          "--option", 'indent_string="  "',
          "--option", "column_width=100",
          "--option", "trailing_newline=true",
          "--option", "array_auto_expand=true",
          "--option", "array_auto_collapse=true",
          "-"
        },
        },
        stdin = false,
        condition = function(ctx)
          return find_root_file({ "biome.json" }, ctx.filename)
        end,
      },

      prettierd = {
        condition = function(ctx)
          return find_root_file({
            ".prettierrc",
            ".prettierrc.json",
            ".prettierrc.yml",
            ".prettierrc.yaml",
            ".prettierrc.json5",
            ".prettierrc.js",
            ".prettierrc.cjs",
            ".prettierrc.mjs",
            ".prettierrc.toml",
            "prettier.config.js",
            "prettier.config.cjs",
            "prettier.config.mjs",
          }, ctx.filename)
        end,
      },
    },
    formatters_by_ft = {
      go = { "gofumpt" },
      css = { "prettierd", "biome" },
      html = { "prettierd" },
      astro = { "prettierd", "biome" },
      json = { "prettierd", "biome" },
      jsonc = { "prettierd", "biome" },
      javascript = { "prettierd", "biome" },
      typescript = { "prettierd", "biome" },
      typescriptreact = { "prettierd", "biome" },
      svelte = { "prettierd" },
      yaml = { "prettierd" },
      lua = { "stylua" },
      python = { "black", "yapf" },
      bash = { "beautysh" },
      zsh = { "beautysh" },
      toml = { "taplo" },
      sql = { "sql_formatter" },
      nix = { "alejandra" },
      markdown = { "prettierd" },
      qml = { "qmlformat" },
    },

    format_on_save = function(bufnr)
      if is_format_enabled(bufnr) then
        return
      end

      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      if slow_format_filetypes[vim.bo[bufnr].filetype] then
        return
      end
      local function on_format(err)
        if err and err:match("timeout$") then
          slow_format_filetypes[vim.bo[bufnr].filetype] = true
        end
      end

      return { timeout_ms = 200, lsp_fallback = true }, on_format
    end,

    format_after_save = function(bufnr)
      if is_format_enabled(bufnr) then
        return
      end

      if not slow_format_filetypes[vim.bo[bufnr].filetype] then
        return
      end
      return { lsp_fallback = true }
    end,
  },
}
