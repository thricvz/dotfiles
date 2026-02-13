-- Tab navigation shortcuts
-- Page to left
vim.keymap.set("n", "<S-l>", ":tabn<cr>")

-- Page to right
vim.keymap.set("n", "<S-h>", ":tabp<cr>")

-- Scrolling through screen
-- Scroll down 
vim.keymap.set("n", "<S-j>",
  function()
    local ctrl_f = string.char(6) 
    vim.api.nvim_feedkeys(ctrl_f, "n", false)
    vim.api.nvim_feedkeys("M", "n", false)
  end
)

--Scroll up
vim.keymap.set("n", "<S-k>",
  function()
    local ctrl_b = string.char(2)
    vim.api.nvim_feedkeys(ctrl_b, "n", false)
    vim.api.nvim_feedkeys("M", "n", false)
  end
)
