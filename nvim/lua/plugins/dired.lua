return {
  "X3eRo0/dired.nvim",
  dependencies = { "MunifTanjim/nui.nvim" },
  config = function()
    require("dired").setup {
      path_separator = "/",
      show_banner = false,
      show_icons = false,
      show_hidden = true,
      show_dot_dirs = true,
      show_colors = true,
    }

    -- local function open_start_buffer()
    --   local args = vim.fn.argv();
    --     if 1 >= #args then
    --     require("dired").open()
    --   end
    -- end
    --
    -- -- Set autocommand to open Dired on VimEnter
    -- vim.api.nvim_create_autocmd("VimEnter", {
    --   callback = open_start_buffer,
    -- })

    -- TODO: function to toogle dired buffer
    vim.keymap.set('n', '<leader>e', '<cmd>Dired<cr>', { desc = 'Dired', noremap = true, silent = true });
    vim.keymap.set('n', '<M-e>', '<cmd>split | Dired<cr>', { desc = 'Dired split', noremap = true, silent = true })
    vim.keymap.set('n', '<M-E>', '<cmd>vsplit | Dired<cr>', { desc = 'Dired vsplit', noremap = true, silent = true })
  end
}
