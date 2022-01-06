local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<A-h>", "<C-w>h", opts)
keymap("n", "<A-j>", "<C-w>j", opts)
keymap("n", "<A-k>", "<C-w>k", opts)
keymap("n", "<A-l>", "<C-w>l", opts)

-- Resize window
keymap("n", "<A-J>", ":resize -2<CR>", opts)
keymap("n", "<A-K>", ":resize +2<CR>", opts)
keymap("n", "<A-H>", ":vertical resize -2<CR>", opts)
keymap("n", "<A-L>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<Tab>", ":bnext<CR>", opts)
keymap("n", "<S-Tab>", ":bprevious<CR>", opts)

-- Insert --

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Don't replace yanked text in register when pasting
keymap("v", "v", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "<S-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<S-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<A-h>", "<C-\\><C-w>h", term_opts)
keymap("t", "<A-j>", "<C-\\><C-w>j", term_opts)
keymap("t", "<A-k>", "<C-\\><C-w>k", term_opts)
keymap("t", "<A-l>", "<C-\\><C-w>l", term_opts)

