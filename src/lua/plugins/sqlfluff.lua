return {
  -- keep the community pack
  { import = "astrocommunity.pack.sql" },

  -- none-ls (null-ls fork): make diagnostics/formatting use postgres
  {
    "jay-babu/mason-null-ls.nvim",
    opts = function(_, opts)
      opts.handlers = opts.handlers or {}
      opts.handlers.sqlfluff = function()
        local null_ls = require "null-ls"
        null_ls.register(null_ls.builtins.diagnostics.sqlfluff.with {
          extra_args = { "--dialect", "postgres" },
        })
        null_ls.register(null_ls.builtins.formatting.sqlfluff.with {
          extra_args = { "--dialect", "postgres" },
        })
      end
    end,
  },

  -- Conform: also switch formatter args to postgres
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = { sql = { "sqlfluff" } },
      formatters = {
        sqlfluff = {
          args = { "fix", "--dialect=postgres", "-" },
          require_cwd = false,
        },
      },
    },
  },
}
