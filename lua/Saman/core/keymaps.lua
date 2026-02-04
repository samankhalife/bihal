vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Move selected lines up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Join lines without moving cursor
vim.keymap.set("n", "J", "mzJ`z")

-- Half-page jump centered
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down centered" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up centered" })

-- Search next/prev centered
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Keep visual selection after indenting
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Paste without overwriting clipboard
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set("v", "p", '"_dp', opts)

-- Yank to system clipboard
vim.keymap.set("n", "<leader>Y", [["+Y]], opts)

-- Delete without yanking
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- Make Ctrl+C behave like Esc (insert mode)
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Clear search highlight
vim.keymap.set("n", "<C-c>", ":nohl<CR>", { desc = "Clear search", silent = true })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Format file using LSP
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- Disable Q
vim.keymap.set("n", "Q", "<nop>")

-- Launch tmux sessionizer
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- Delete single char without yanking
vim.keymap.set("n", "x", '"_x', opts)

-- Global replace word under cursor
vim.keymap.set("n", "<leader>s",
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "Replace word globally" }
)

-- Make current file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make file executable" })

-- Tab management
vim.keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "New tab" })
vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close tab" })
vim.keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Next tab" })
vim.keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Previous tab" })
vim.keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open file in new tab" })

-- Splits
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Vertical split" })
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Horizontal split" })
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Equalize splits" })
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close split" })

-- Move between splits
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Focus left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Focus right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Focus lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Focus upper window" })

-- Diagnostics
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Toggle LSP diagnostics
local diag_visible = true
vim.keymap.set("n", "<leader>lx", function()
    diag_visible = not diag_visible
    vim.diagnostic.config({
        virtual_text = diag_visible,
        underline = diag_visible,
    })
end, { desc = "Toggle LSP diagnostics" })

-- Copy file path
vim.keymap.set("n", "<leader>fp", function()
    local filePath = vim.fn.expand("%:~")
    vim.fn.setreg("+", filePath)
    print("File path copied: " .. filePath)
end, { desc = "Copy file path" })

-- Highlight yanked text (only once!)
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight on yank",
    group = vim.api.nvim_create_augroup("highlight_on_yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})
