---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  opts = function(_, config)
    local u = require "null-ls.utils"

    -- Check supported formatters and linters
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics

    config.root_dir = u.root_pattern(".sqlfluff", ".git", "pyproject.toml")
    return config
  end,
}
