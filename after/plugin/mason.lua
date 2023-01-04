local ok, _ = pcall(require, 'mason')
if not ok then
    error('ERROR: mason not found')
    return
end

local ok, _ = pcall(require, 'mason-lspconfig')
if not ok then
    error('ERROR: mason-lspconfig not found')
    return
end

local ok, _ = pcall(require, 'lspconfig')
if not ok then
    error('ERROR: lspconfig not found')
    return
end

local ok, _ = pcall(require, 'cmp_nvim_lsp')
if not ok then
    error('ERROR: cmp_nvim_lsp not found')
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

local ok, _ = pcall(require, "inc_rename")
if not ok then
    error("ERROR - inc_reaname not found")
    return
end

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
    -- vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, options)
    vim.keymap.set("n", "<leader>rn", ":IncRename ")
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, options)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, options)
    vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, options)
end

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local setup = {
    flags = {
        debounce_text_changes = 100,
    },
    autostart = true,
    on_attach = on_attach,
    capabilities = capabilities
}

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local options = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, options)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, options)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, options)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, options)

require("lspconfig").sumneko_lua.setup(setup)
require("lspconfig").pyright.setup(setup)
require("lspconfig").hls.setup(setup)
require("inc_rename").setup {
    cmd_name = "IncRename", -- the name of the command
    hl_group = "Substitute", -- the highlight group used for highlighting the identifier's new name
    preview_empty_name = false, -- whether an empty new name should be previewed; if false the command preview will be cancelled instead
    show_message = true, -- whether to display a `Renamed m instances in n files` message after a rename operation
    input_buffer_type = nil, -- the type of the external input buffer to use (the only supported value is currently "dressing")
    post_hook = nil, -- callback to run after renaming, receives the result table (from LSP handler) as an argument
}
