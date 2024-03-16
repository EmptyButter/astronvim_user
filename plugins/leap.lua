return {
  {
    "ggandor/leap.nvim",
    -- event = "VeryLazy",
    lazy = false,
    dependencies = {
      "tpope/vim-repeat",
    },
    config = function() require("leap").create_default_mappings() end,
  },
}
