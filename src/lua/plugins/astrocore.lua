-- Configuration documentation can be found with `:h astrocore`

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 500, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = false,
      cmp = true,
      diagnostics_mode = 3,
      highlighturl = true,
      notifications = true,
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = false,
        number = true,
        spell = true,
        signcolumn = "auto",
        wrap = false,
        textwidth = 88,
        formatoptions = "ro/qj",
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        ["<Leader>bD"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Pick to close",
        },
        ["<Leader>y"] = { name = "Advanced Copy" },
        ["<Leader>yp"] = {
          function()
            local filepath = vim.fn.expand "%:p"
            vim.fn.setreg("+", filepath)
          end,
          desc = "Copy file path to clipboard",
        },
        ["<Leader>yc"] = {
          function()
            local ts_utils = require "nvim-treesitter.ts_utils"

            local function get_node_text(node)
              if not node then return nil end
              local start_row, start_col, end_row, end_col = node:range()
              return vim.api.nvim_buf_get_text(0, start_row, start_col, end_row, end_col, {})[1]
            end

            local node = ts_utils.get_node_at_cursor()
            local method_name, class_name = nil, nil
            local filepath = vim.fn.expand "%:p"

            while node do
              local type = node:type()
              if type == "function_definition" or type == "function_declaration" or type == "method_definition" then
                method_name = get_node_text(node:field("name")[1])
              elseif type == "class_definition" then
                class_name = get_node_text(node:field("name")[1])
              end
              node = node:parent()
            end

            local classpath = filepath
            if class_name then classpath = filepath .. "::" .. class_name end
            if method_name then classpath = classpath .. "::" .. method_name end

            vim.fn.setreg("+", classpath)
          end,
          desc = "Copy class path to clipboard",
        },
      },
      t = {
        -- setting a mapping to false will disable it
        -- ["<esc>"] = false,
      },
    },
  },
}
