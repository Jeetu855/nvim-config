vim.g.mapleader = " "

local keymap = vim.keymap

-- normal mode
keymap.set("i", "kj", "<Esc>")

-- save file with ctrl-s
vim.api.nvim_set_keymap("n", "<C-s>", ":w<CR>", { noremap = true })
vim.api.nvim_set_keymap("i", "<C-s>", "<C-o>:write<CR>a", { noremap = true })

-- select all with ctrl-a
vim.api.nvim_set_keymap("n", "<C-a>", "ggVG", { noremap = true, silent = true, desc = "select all" })

-- for clearing highlight on search
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "clear search highlights" })

-- J to move the current line down
vim.keymap.set("n", "J", ":m .+1<CR>==", { desc = "move line down", noremap = true, silent = true })
-- K to move the current line up (use g? to show docs for something)
vim.keymap.set("n", "K", ":m .-2<CR>==", { desc = "move line up", noremap = true, silent = true })

-- increment or decrement numbers
keymap.set("n", "<leader>=", "<C-a>", { desc = "increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "decrement number" })

-- spliting windows
keymap.set("n", "<leader>ss", ":vsplit<CR>", { desc = "split window vertically" })
keymap.set("n", "<leader>sh", ":split<CR>", { desc = "split window horizontally" })
keymap.set("n", "<leader>sv", "<C-w>=", { desc = "make windows equal size" })
keymap.set("n", "<leader>sl", "<cmd>close<CR>", { desc = "close current split" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "move to right split", noremap = true, silent = true })
keymap.set("n", "<C-h>", "<C-w>h", { desc = "move to left split", noremap = true, silent = true })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "move to down split", noremap = true, silent = true })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "move to up split", noremap = true, silent = true })

-- tab management
keymap.set("n", "<leader>tt", "<cmd>tabnew<CR>", { desc = "open new tab" })
keymap.set("n", "<leader>tl", "<cmd>tabclose<CR>", { desc = "close current tab" })
keymap.set("n", "<tab>l", "<cmd>tabn<CR>", { desc = "go to next tab" })
keymap.set("n", "<tab>h", "<cmd>tabp<CR>", { desc = "go to previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "open current buffer in new tab" })

-- comment using ctr+ / ---
vim.keymap.set(
	"v",
	"?",
	":s/^/\\/\\/<CR>:nohl<CR>gv",
	{ desc = "comment selected lines", noremap = true, silent = true }
)

-- rebind Alt + l to go to the end of the line ($)
keymap.set({ "n", "x", "o" }, "<A-l>", "$", { noremap = true, silent = true, desc = "Go to end of line" })

-- rebind ALt + h to go to the beginning of the line (0)
keymap.set({ "n", "x", "o" }, "<A-h>", "^", { noremap = true, silent = true, desc = "Go to start of line" })

keymap.set("n", "<A-l>", "$", { noremap = true, silent = true, desc = "go to end of line" })

-- auto center on pg up or pg down
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")
