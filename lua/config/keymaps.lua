-- Tab navigation shortcuts
-- Page to left
vim.keymap.set("n", "<S-l>", ":tabn<cr>")

-- Page to right
vim.keymap.set("n", "<S-h>", ":tabp<cr>")

-- Scrolling through screen
-- Scroll down 
vim.keymap.set("n", "<S-k>",
  function()
    local ctrl_u = string.char(21) 
    vim.api.nvim_feedkeys(ctrl_u, "n", false)
  end
)

--Scroll up
vim.keymap.set("n", "<S-j>",
  function()
    local ctrl_d = string.char(4)
    vim.api.nvim_feedkeys(ctrl_d, "n", false)
  end
)

--new command
vim.api.nvim_create_user_command('Sh', 
  function()
    vim.cmd('term')
    vim.cmd('startinsert')
  end,
{})
