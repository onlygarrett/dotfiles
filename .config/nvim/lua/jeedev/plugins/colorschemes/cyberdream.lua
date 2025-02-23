return {
  "scottmckendry/cyberdream.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("cyberdream").setup({
      transparent = false,
      italic_comments = true,
      hide_fillchars = true,
      borderless_pickers = false,
      terminal_colors = true,
      cache = true,
      extensions = {
        alpha = true,
        indentblankline = true,
      },
    })
    --
    -- vim.cmd("colorscheme cyberdream")
  end,
}
