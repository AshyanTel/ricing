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
    },
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter").install({
            "markdown", "markdown_inline",
            "python", "lua", "java", "cpp", "nix",
            "bash", "fish", "rust", "ruby",
            "markdown", "markdown_inline", "html",
            "yaml", "toml", "latex", "json",
            })
        end,
    },
    {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        opts = {},
    },
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                markdown = { "prettier" },
            },
            formatters = {
                prettier = {
                    prepend_args = {
                        "--prose-wrap", "preserve",
                        "--print-width", "80",
                    },
                },
            },
        },
    },
    {
        "obsidian-nvim/obsidian.nvim",
        version = "*",
        ft = "markdown",
        keys = {
            { "<leader>oo", "<cmd>Obsidian quick_switch<cr>",      desc = "Obsidian: Open note." },
            { "<leader>os", "<cmd>Obsidian search<cr>",            desc = "Obsidian: Search." },
            { "<leader>on", "<cmd>Obsidian new_from_template<cr>", desc = "Obsidian: New note." },
            { "<leader>ot", "<cmd>Obsidian today<cr>",             desc = "Obsidian: Open today notes." },
            { "<leader>ob", "<cmd>Obsidian backlinks<cr>",         desc = "Obsidian: Open backlinks." },
            { "<leader>ol", "<cmd>Obsidian links<cr>",             desc = "Obsidian: Open links." },
            { "<leader>oT", "<cmd>Obsidian template<cr>",          desc = "Obsidian: Use a template." },
        },
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "markdown",
                callback = function()
                    vim.opt_local.conceallevel = 2
                end,
            })
        end,
        opts = {
            legacy_commands = false,
            note_id_func = function(title)
                if title == nil then
                    return tostring(os.time())
                end
                local map = {
                    ["à"] = "a", ["â"] = "a",  ["ä"] = "a",
                    ["é"] = "e", ["è"] = "e", ["ê"] = "e", ["ë"] = "e",
                    ["î"] = "i", ["ï"] = "i",
                    ["ô"] = "o", ["ö"] = "o",
                    ["ù"] = "u", ["û"] = "u", ["ü"] = "u",
                    ["ç"] = "c", ["œ"] = "oe", ["æ"] = "ae"
                }
                local slug = vim.fn.tolower(title)
                slug = slug:gsub("[%z\1-\127\194-\244][\128-\191]*", function(c)
                    return map[c] or c
                end)
                slug = slug:gsub(" ","-"):gsub("[^a-z0-9-]", "")
                return slug
            end,
            workspaces = {
                { name = "vault", path = "~/vault" },
            },
            templates = {
                folder = "templates",
            },
        },
    },
    {
        "mfussenegger/nvim-lint",
        config = function()
            require("lint").linters_by_ft = {
                markdown = { "markdownlint-cli2" },
            }
            vim.api.nvim_create_autocmd(
                { "BufReadPost", "BufWritePost", "InsertLeave" },
                {
                    callback = function()
                        require("lint").try_lint()
                    end,
                }
            )
        end,
    },
    {
        "junegunn/vim-easy-align",
        cmd = "EasyAlign",
        keys = {
            { "<leader>=", ":EasyAlign ", mode = "x", desc = "Align" },
        },
    },
    {
        "dhruvasagar/vim-table-mode",
        ft = "markdown",
        init = function()
            vim.g.table_mode_corner = "|"
        end,
    },
    {
        "ibhagwan/fzf-lua",
        dependecies = { "nvim-tree/nvim-web-devicons" },
        opts = {},
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
    {
        "3rd/image.nvim",
        build = false,
        opts = {
            backend = "kitty",
            processor = "magick_cli",
            integrations = {
                markdown = { enabled = false },
                neorg = { enabled = false },
            },
        },
    },
    {
        "benlubas/molten-nvim",
        version = "^1.0.0",
        build = ":UpdateRemotePlugins",
        init = function()
            vim.g.molten_image_provider = "image.nvim"
            vim.g.molten_auto_open_output = true
            vim.g.molten_virt_text_output = true
        end,
    },
})
