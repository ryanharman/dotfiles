return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = { "astro", "typescript", "lua", "vim", "vimdoc", "php", "javascript", "html", "dockerfile", "go", "graphql", "json", "prisma", "svelte", "tsx" },
        sync_install = false,
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
  }
}