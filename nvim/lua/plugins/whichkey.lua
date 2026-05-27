return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      local wk = require("which-key")
      wk.add({
        { "<leader>f", group = "picker" },
        { "<leader>g", group = "git" },
        { "<leader>h", group = "hunks" },
        { "<leader>t", group = "test" },
        { "<leader>\\", desc = "Neotree" },
      })
    end,
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  }
}