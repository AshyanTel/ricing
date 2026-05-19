local au = vim.api.nvim_create_autocmd

au("FileType", {
    pattern = "make",
    callback = function()
        vim.opt_local.expandtab = false
    end,
})

au("FileType", {
    pattern = { "c", "cpp", "ruby", "eruby", "nix" },
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
    end,
})

-- require('overlength').setup({
--     enable = true,
--     colors = {
--         ctermfg = nil,
--         ctermbg = 'darkgrey',
--         fg = nil,
--         bg = '#8B0000'
--     },
--
--     textwidth_mode = 1,
--     default_overlength = 80,
--     grace_lenght = 1,
--     highlight_to_eol = true,
--
--     disable_ft = { 'qf', 'help', 'man', 'checkhealth', 'lazy', 'packer', 'NvimTree', 'Telescope', 'TelescopePrompt', 'TelescopeResults', 'WhichKey' },
-- })

au("FileType", {
    callback = function()
        vim.opt_local.formatoptions = "tcroql"
    end,
})
