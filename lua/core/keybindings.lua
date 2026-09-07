local function map(m, k, v, opts)
  vim.keymap.set(m, k, v, vim.tbl_deep_extend("force", { silent = true, noremap = true }, opts or {}))
end

-- General Settings
map("n", "*", "*N", { desc = "Fix * (Keep the cursor position, don't move to next match)" })
map("n", "<C-Q>", ":q!<CR>", { desc = "Quit neovim" })
map("i", "<C-Backspace>", "<C-W>", { noremap = true, desc = "Delete a word" })

-- Spell check
map("n", "<leader>s", ":setlocal spell spelllang=en_us<CR>", { desc = "Turn on spell check" })

-- Session Manager
map("n", "<C-s>", require("auto-session").search, { desc = "Project hop" })

map("n", "<leader>ca", function()
  local bufnr = vim.api.nvim_get_current_buf()
  local win = vim.api.nvim_get_current_win()
  local lnum = vim.api.nvim_win_get_cursor(win)[1] - 1

  -- Replacement for the deprecated vim.lsp.diagnostic.get_line_diagnostics(bufnr)
  -- Diagnostics must be converted to LSP format for the codeAction context.
  local diagnostics = {}
  for _, d in ipairs(vim.diagnostic.get(bufnr, { lnum = lnum })) do
    diagnostics[#diagnostics + 1] = d.user_data and d.user_data.lsp or {
      range = {
        start = { line = d.lnum, character = d.col },
        ["end"] = { line = d.end_lnum, character = d.end_col },
      },
      severity = d.severity,
      message = d.message,
      source = d.source,
      code = d.code,
    }
  end

  local context = {
    diagnostics = diagnostics,
    triggerKind = vim.lsp.protocol.CodeActionTriggerKind.Invoked,
  }

  Snacks.picker.pick(nil, {
    title = "Code Actions",
    layout = "select",
    format = "text",
    finder = function()
      -- Pass params as a function so each client gets its own offset_encoding,
      -- avoiding the make_range_params() and mixed-offset-encoding warnings.
      local results = vim.lsp.buf_request_sync(
        bufnr,
        "textDocument/codeAction",
        function(client)
          local params = vim.lsp.util.make_range_params(win, client.offset_encoding)
          params.context = context
          return params
        end,
        1000
      )
      if not results then
        return {}
      end

      local items = {}
      for client_id, res in pairs(results) do
        if res.result then
          local client = vim.lsp.get_client_by_id(client_id)
          for _, action in ipairs(res.result) do
            table.insert(items, {
              text = action.title,
              action = action,
              offset_encoding = client and client.offset_encoding or "utf-16",
              client_id = client_id,
            })
          end
        end
      end
      return items
    end,
    confirm = function(picker, item)
      picker:close()
      if not item then
        return
      end

      local action = item.action

      -- Some actions just have an edit, some have a command, some have both.
      if action.edit then
        vim.lsp.util.apply_workspace_edit(action.edit, item.offset_encoding)
      end

      if action.command then
        local command = type(action.command) == "table" and action.command or action
        local client = vim.lsp.get_client_by_id(item.client_id)
        -- Replacement for the deprecated vim.lsp.buf.execute_command()
        if client then
          client:exec_cmd(command)
        end
      end
    end,
  })
end, { desc = "code actions" })

-- Formatter
map("n", "<Space>f", function()
  local status_ok, format = pcall(require, "conform")
  if not status_ok then
    return
  end
  format.format({ async = true, lsp_fallback = true })
end, { desc = "Format code" })

-- Switch panes
map("n", "<C-k>", ":wincmd k<CR>")
map("n", "<C-j>", ":wincmd j<CR>")
map("n", "<C-h>", ":wincmd h<CR>")
map("n", "<C-l>", ":wincmd l<CR>")

-- Neovide: change dynamic font size at runtime
vim.g.neovide_scale_factor = 1.0
local change_scale_factor = function(delta)
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end

map("n", "<C-=>", function()
  change_scale_factor(1.25)
end)

map("n", "<C-->", function()
  change_scale_factor(1 / 1.25)
end)

-- Remap for dealing with word wrap
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
