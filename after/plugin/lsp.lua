require("neodev").setup({})

local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
  "tsserver",
  "eslint",
  "lua_ls",
})

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
  ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
  ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
  ["<C-y>"] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})

lsp.setup_nvim_cmp({
  mapping = cmp_mappings,
})

lsp.set_sign_icons({
  error = "✘",
  warn = "▲",
  hint = "⚑",
  info = "»",
})

lsp.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings to learn the available actions
  lsp.default_keymaps({ buffer = bufnr })
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "code actions" })
  vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "rename reference under cursor" })
end)

-- local lspconfig = require("lspconfig")

-- lspconfig.eslint.setup({
--   settings = {
--     workingDirectory = { mode = "auto" },
--   },
-- })

lsp.setup()

local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.prettierd
  }
})
