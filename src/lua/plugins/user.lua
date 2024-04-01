---@type LazySpec
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      require("catppuccin").setup { flavour = "mocha", }
    end,
  },
}
