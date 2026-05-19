local map = vim.keymap.set

vim.g.mapleader = ","

map("n", "<leader>w", ":wa<CR>")
map("n", "<leader>q", ":bd<CR>")
map("n", "<leader>x", ":wqa<CR>")

map("n", "p", "p`[")
map("n", "<F5>", function()
    local view = vim.fn.winsaveview()
    local search = vim.fn.getreg("/")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setreg("/", search)
    vim.fn.winrestview(view)
end)

map("n", "<leader>f", ":Files<CR>")
map("n", "<leader>b", ":Buffers<CR>")
map("n", "<leader>g", ":Rg<CR>")
map("n", "<leader>p", ":MarkdownPreviewToggle<CR>")
