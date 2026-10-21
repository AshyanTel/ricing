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
vim.keymap.set("v", "<leader>jv", ":<C-u>MoltenEvaluateVisual<CR>gv", { silent = true })

local function run_cell()
  local cur, last = vim.fn.line("."), vim.fn.line("$")
  local s = cur
  while s >= 1 and not vim.fn.getline(s):match("^# %%") do s = s - 1 end
  local e = cur + 1
  while e <= last and not vim.fn.getline(e):match("^# %%") do e = e + 1 end
  vim.fn.setpos("'<", { 0, s + 1, 1, 0 })
  vim.fn.setpos("'>", { 0, e - 1, 1, 0 })
  vim.cmd("MoltenEvaluateVisual")
end
vim.keymap.set("n", "<leader>jr", run_cell, { desc = "Run cell" })

local function sync_notebook()
  vim.cmd("write")
  local file = vim.fn.expand("%:p")
  vim.system({ "jupytext", "--sync", file }, { text = true }, function(res)
    vim.schedule(function()
      if res.code == 0 then
        vim.notify("jupytext: synchronisé")
      else
        vim.notify("jupytext: " .. (res.stderr or "erreur"), vim.log.levels.ERROR)
      end
    end)
  end)
end

vim.keymap.set("n", "<leader>js", sync_notebook, { desc = "Sync notebook" })
