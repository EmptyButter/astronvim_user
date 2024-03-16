return {
  {
    "rebelot/kanagawa.nvim",
    opts = {
      colors = { -- add/modify theme and palette colors
        theme = {
          lotus = {
            ui = {
              bg = "#FCF3CF",
            },
          },
        },
      },
      overrides = function(colors) -- add/modify highlights
        return {}
      end,
      theme = "wave", -- Load "wave" theme when 'background' option is not set
      background = { -- map the value of 'background' option to a theme
        dark = "dragon", -- try "dragon" !
        light = "lotus",
      },
    },
  },
}
