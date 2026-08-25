return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    cmd = "Snacks",
    lazy = false,
    opts = {
      input = {},
      picker = {
        prompt = " ",
      },
      debug = {},
      dim = {},
      explorer = {
        enabled = false,
      },
      notifier = {},
      indent = {},
      rename = {},
      git = {
        width = 0.6,
        height = 0.6,
        border = true,
        title = " Git Blame ",
        title_pos = "center",
        ft = "git",
      },
    },

    -- stylua: ignore
    keys = {
      { "<leader>e", function() Snacks.explorer.open() end },
      { "<leader>b", function() Snacks.git.blame_line() end },
      { "<leader>gb", function() Snacks.gitbrowse.open() end },
      { "<leader>lg", function() Snacks.lazygit.open() end },
      { "<leader>sp", function() Snacks.scratch.open() end },

      -- Top Pickers & Explorer
      { "<leader><space>", function() Snacks.picker.smart() end },
      { "<leader>,", function() Snacks.picker.buffers() end },
      { "<leader>/", function() Snacks.picker.grep() end },
      { "<leader>:", function() Snacks.picker.command_history() end },
      { "<leader>n", function() Snacks.picker.notifications() end },
      { "<leader>e", function() Snacks.explorer() end },

      -- find
      { "<leader>fb", function() Snacks.picker.buffers() end },
      { "<leader>ff", function() Snacks.picker.files() end },
      { "<leader>fg", function() Snacks.picker.grep() end },
      { "<leader>fp", function() Snacks.picker.projects() end },
      { "<leader>fr", function() Snacks.picker.recent() end },

      -- git
      { "<leader>gb", function() Snacks.picker.git_branches() end },
      { "<leader>gl", function() Snacks.picker.git_log() end },
      { "<leader>gL", function() Snacks.picker.git_log_line() end },
      { "<leader>gs", function() Snacks.picker.git_status() end },
      { "<leader>gS", function() Snacks.picker.git_stash() end },
      { "<leader>gd", function() Snacks.picker.git_diff() end },
      { "<leader>gf", function() Snacks.picker.git_log_file() end },

      -- Grep
      { "<leader>sb", function() Snacks.picker.lines() end },
      { "<leader>sB", function() Snacks.picker.grep_buffers() end },
      { "<leader>sg", function() Snacks.picker.grep() end },
      { "<leader>sw", function() Snacks.picker.grep_word() end, mode = { "n", "x" } },
    },
  },
}
