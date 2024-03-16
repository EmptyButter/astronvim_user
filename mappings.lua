-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)

-- Harpoon setup
local harpoon = require "harpoon"
harpoon:setup {}
-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
  local file_paths = {}
  for _, item in ipairs(harpoon_files.items) do
    table.insert(file_paths, item.value)
  end

  require("telescope.pickers")
    .new({}, {
      prompt_title = "Harpoon",
      finder = require("telescope.finders").new_table {
        results = file_paths,
      },
      previewer = conf.file_previewer {},
      sorter = conf.generic_sorter {},
    })
    :find()
end
-- add event listener
harpoon:extend { ADD = function(data) vim.notify(data.item.value .. " harpooned", 2, { title = "Harpoon" }) end }
harpoon:extend { REMOVE = function(data) vim.notify(data.item.value .. " removed", 2, { title = "Harpoon" }) end }

return {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map

    -- navigate buffer tabs with `H` and `L`
    L = {
      function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
      desc = "Next buffer",
    },
    H = {
      function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
      desc = "Previous buffer",
    },

    -- harpoon key mappings
    ["<C-a>"] = {
      function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
        -- toggle_telescope(harpoon:list())
      end,
      desc = "Harpoon open",
    },
    -- ["<leader>j"] = {
    ["<leader>j"] = {
      function() harpoon:list():append() end,
      desc = "harpoon append list",
    },
    ["<leader>k"] = {
      function() harpoon:list():remove() end,
      desc = "harpoon remove item",
    },
    ["<leader>hc"] = {
      function()
        harpoon:list():clear()
        vim.notify("List cleared", 2, { title = "harpoon" })
      end,
      desc = "harpoon clear list",
    },
    ["<leader>hh"] = {
      function() harpoon:list():prev() end,
      desc = "harpoon previous page",
    },
    ["<leader>hl"] = {
      function() harpoon:list():next() end,
      desc = "harpoon next page",
    },
    ["<C-b>"] = {
      function() harpoon:list():select(1) end,
      desc = "harpoon 1",
    },
    ["<C-n>"] = {
      function() harpoon:list():select(2) end,
      desc = "harpoon 2",
    },
    ["<C-m>"] = {
      function() harpoon:list():select(3) end,
      desc = "harpoon 3",
    },

    -- mappings seen under group name "Buffer"
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(
          function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        )
      end,
      desc = "Pick to close",
    },
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>b"] = { name = "Buffers" },
    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
}
