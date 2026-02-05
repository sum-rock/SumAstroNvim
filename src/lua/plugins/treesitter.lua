---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    opts.highlight = opts.highlight or {}
    opts.highlight.additional_vim_regex_highlighting =
      require("astrocore").list_insert_unique(opts.highlight.additional_vim_regex_highlighting or {}, { "sql" })
  end,
}
