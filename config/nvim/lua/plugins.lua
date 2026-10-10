local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none", "--branch=stable",
        "https://github.com/folke/lazy.nvim.git", lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        opts = {
            transparent_background = true,
        },
        config = function(_, opts)
            require("catppuccin").setup(opts)
            vim.cmd.colorscheme("catppuccin")
        end,
    },{
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter").install({
            "markdown", "markdown_inline",
            "python", "lua", "java", "cpp", "nix",
            "bash", "fish", "rust", "ruby"
            })
        end,
    },
    {
        "iamcco/markdown-preview.nvim",
        ft = { "markdown" },
        build = "cd app && npm install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
    },
    {
        "saghen/blink.cmp",
        version = "1.*",
        opts = {
            keymap = { preset = "super-tab" },
            sources = { default = { "lsp", "path", "snippets", "buffer" } },
        },
    },
    { "junegunn/fzf", build = "./install --bin" },
    { "junegunn/fzf.vim" },
    { "lcheylus/overlength.nvim" },
    {
        "nvim-treesitter/nvim-treesitter-context",
        opts = { max_lines = 4, separator = "─"},
        config = function (_, opts)
            require("treesitter-context").setup(opts)
            vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "NONE" })
            vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", { bg = "NONE"})
            vim.api.nvim_set_hl(0, "TreesitterContextSeparator", { link = "Comment" })
        end,
    },
    {
        "mikavilpas/yazi.nvim",
        cmd = "Yazi",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
    },
    {
        "Aasim-A/scrollEOF.nvim",
        event = { "CursorMoved", "WinScrolled" },
        opts = {},
    },
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            current_line_blame = true,
            current_line_blame_opts = { delay = 500 },
        },
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {},
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {

        },
        config = function()
            local hooks = require("ibl.hooks")
            hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
                vim.api.nvim_set_hl(0, "IblIndent", { fg = "#313244" })
            end)
            require("ibl").setup({
                indent = { char = "│", highlight = "IblIndent" },
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        config = function ()
            require("nvim-treesitter-textobjects").setup({
                select = { lookahead = true },
            })
            local select = require("nvim-treesitter-textobjects.select")
            local map = vim.keymap.set
            local objects = {
                af = "@function.outer",
                ["if"] = "@function.inner",
                ac = "@class.outer",
                ic = "@class.inner",
                aa = "@parameter.outer",
                ia = "@parameter.inner",
            }
            for key, query in pairs(objects) do
                map({ "x", "o"}, key, function ()
                    select.select_textobject(query, "textobjects")
                end)
            end
            local move = require("nvim-treesitter-textobjects.move")
            map({ "n", "x", "o" }, "]f", function()
                move.goto_next_start("@function.outer", "textobjects")
            end)
            map({ "n", "x", "o" }, "[f", function()
                move.goto_previous_start("@function.outer", "textobjects")
            end)
        end
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {},
    },
})
