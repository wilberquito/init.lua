local ok, _ = pcall(require, "mason")
if not ok then
    error('ERROR: mason not found')
    return
end

local ok, _ = pcall(require, "mason-lspconfig")
if not ok then
    error('ERROR: mason-lspconfig not found')
    return
end

local ok, _ = pcall(require, "lspconfig")
if not ok then
    error('ERROR: lspconfig not found')
    return
end

require("mason").setup {
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
}

require("mason-lspconfig").setup {
    ensure_installed = {
        "sumneko_lua",
        "hls",
        "pyright"
    },
}

local on_attach = function(client, bufnr)
    -- LSP config mappings
    local options = { noremap = true }
    vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', options)
    vim.api.nvim_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', options)
    vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', options)
    vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', options)
    vim.api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', options)
    vim.api.nvim_set_keymap('n', '<leader>ds', '<cmd>lua vim.lsp.buf.signature_help()<CR>', options)
    vim.api.nvim_set_keymap('n', '<leader>dn', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', options)
    vim.api.nvim_set_keymap('n', '<leader>dp', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', options)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, options)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, options)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, options)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, options)
    vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, options)
end

local setup = {
    flags = {
        debounce_text_changes = 100,
    },
    autostart = true,
    on_attach = on_attach
}

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)


require("lspconfig").sumneko_lua.setup(setup)
require("lspconfig").pyright.setup(setup)
require("lspconfig").hls.setup(setup)
