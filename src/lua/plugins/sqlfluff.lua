return {
  -- Treesitter SQL parser
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "sql" })
    end,
  },

  -- Install sqls via mason
  {
    "mason-org/mason-lspconfig.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "sqls" })
    end,
  },

  -- Configure sqls LSP (no nanotee/sqls.nvim needed)
  {
    "AstroNvim/astrolsp",
    opts = {
      config = {
        sqls = {
          on_attach = function(client, _)
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
          end,
        },
      },
    },
  },

  -- sqlfluff: postgres dialect
  {
    "jay-babu/mason-null-ls.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "sqlfluff" })
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

  -- Conform: postgres formatter
  {
    "stevearc/conform.nvim",
    optional = true,
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
