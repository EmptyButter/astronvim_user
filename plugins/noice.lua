return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup {
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
          },
          hover = {
            enabled = false,
          },
          signature = {
            enabled = false,
          },
        },
        -- you can enable a preset for easier configuration
        -- presets = {
        --   bottom_search = false, -- use a classic bottom cmdline for search
        --   command_palette = true, -- position the cmdline and popupmenu together
        --   long_message_to_split = true, -- long messages will be sent to a split
        --   inc_rename = false, -- enables an input dialog for inc-rename.nvim
        --   lsp_doc_border = false, -- add a border to hover docs and signature help
        -- },
        cmdline = {
          enabled = true, -- enables the Noice cmdline UI
          view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
          opts = {}, -- global options for the cmdline. See section on views
          format = {
            -- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
            -- view: (default is cmdline view)
            -- opts: any options passed to the view
            -- icon_hl_group: optional hl_group for the icon
            -- title: set to anything or empty string to hide
            -- cmdline = { pattern = "^:", icon = "", lang = "vim" },
            -- search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
            -- search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
            -- filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
            -- lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
            -- help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
            -- input = {}, -- Used by input()
            -- lua = false, -- to disable a format, set to `false`
          },
        },
        views = {
          cmdline_popup = {
            border = { style = "rounded" },
          },
        },
      }

      local search = vim.api.nvim_get_hl_by_name("Search", true)
      vim.api.nvim_set_hl(0, "TransparentSearch", { fg = search.foreground })

      local help = vim.api.nvim_get_hl_by_name("IncSearch", true)
      vim.api.nvim_set_hl(0, "TransparentHelp", { fg = help.foreground })

      local cmdGroup = "DevIconLua"
      local noice_cmd_types = {
        CmdLine = cmdGroup,
        Input = cmdGroup,
        Lua = cmdGroup,
        Filter = cmdGroup,
        Rename = cmdGroup,
        Substitute = "Define",
        Help = "TransparentHelp",
        Search = "TransparentSearch",
      }

      for type, hl in pairs(noice_cmd_types) do
        vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder" .. type, { link = hl })
        vim.api.nvim_set_hl(0, "NoiceCmdlineIcon" .. type, { link = hl })
      end
      vim.api.nvim_set_hl(0, "NoiceCmdlinePopupTitle", { link = cmdGroup })
      vim.api.nvim_set_hl(0, "NoiceConfirmBorder", { link = cmdGroup })
    end,
  },
}
