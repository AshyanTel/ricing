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
map("n",  "<leader>y", "<cmd>Yazi<CR>")
vim.keymap.set({ "n", "v" }, "<leader>mf", function()
    require("conform").format({ lsp_format = "fallback" })
end, { desc = "Formater le buffer md" })
local function outline()
    local buf = vim.api.nvim_get_current_buf()
    local params = { textDocument = vim.lsp.util.make_text_document_params(buf) }
    vim.lsp.buf_request(buf, "textDocument/documentSymbol", params, function(err, result)
        if err or not result then return end
        local items = {}
        local function walk(symbols, depth)
            for _, s in ipairs(symbols) do
                local line = s.range.start.line + 1
                table.insert(items, string.format("%4d  %s%s", line, string.rep("  ", depth), s.name))
                walk(s.children or {}, depth + 1)
            end
        end
        walk(result, 0)
        require("fzf-lua").fzf_exec(items, {
            actions = {
                ["default"] = function(selected)
                    local l = tonumber(selected[1]:match("^%s*(%d+)"))
                    vim.api.nvim_win_set_cursor(0, { l, 0 })
                end,
            },
        })
    end)
end
vim.keymap.set("n", "<leader>mo", outline, { desc = "Outline (markdown)" })
