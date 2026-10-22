vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
})

vim.lsp.config("lua_ls", {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = { ".luarc.json", ".git" },
    settings = {
        Lua = { diagnostics = { globals = { "vim" } } },
    },
})
vim.lsp.enable("lua_ls")

vim.lsp.config("clangd", {
  cmd = { "clangd" },
  filetypes = { "c", "cpp" },
  root_markers = { "compile_commands.json", ".clangd", ".git" },
})
vim.lsp.enable("clangd")

vim.lsp.config("jdtls", {
    cmd = { "jdtls" },
    filetypes = { "java" },
    root_markers = { ".idea", "pom.xml", "build.gradle", "flake.nix", ".git" },
    settings = {
        java = {
            sourcePaths = { "src" },
        },
    },
})
vim.lsp.enable("jdtls")

vim.lsp.config("nixd", {
  cmd = { "nixd" },
  filetypes = { "nix" },
  root_markers = { "flake.nix", ".git" },
})
vim.lsp.enable("nixd")

vim.lsp.config("fish_lsp", {
  cmd = { "fish-lsp", "start" },
  filetypes = { "fish" },
  root_markers = { ".git" },
})
vim.lsp.enable("fish_lsp")

vim.lsp.config("bashls", {
  cmd = { "bash-language-server", "start" },
  filetypes = { "sh", "bash" },
  root_markers = { ".git" },
})
vim.lsp.enable("bashls")

vim.lsp.config("rust_analyzer", {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_markers = { "Cargo.toml", "rust-project.json", ".git" },
})
vim.lsp.enable("rust_analyzer")

vim.lsp.config("marksman", {
    cmd = { "marksman", "server" },
    filetypes = { "markdown" },
    root_markers = { ".marksman.toml", ".obsidian", ".git" },
})
vim.lsp.enable("marksman")

vim.lsp.config("pyright", {
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", ".git" },
})
vim.lsp.enable("pyright")

vim.lsp.config("asm_lsp", {
  cmd = { "asm-lsp" },
  filetypes = { "asm", "vmasm" },
  root_markers = { ".asm-lsp.toml", ".git" },
})
vim.lsp.enable("asm_lsp")

vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
