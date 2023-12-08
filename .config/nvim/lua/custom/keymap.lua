-- [[ Basic Keymaps ]]
-- Keep the cursor in the middle of the screen when paging up and down
vim.keymap.set('n', "<c-u>", "<c-u>zz")
vim.keymap.set('n', "<c-d>", "<c-d>zz")
-- vim.keymap.set('n', "<c-e>", "<c-e>M")
-- vim.keymap.set('n', "<c-y>", "<c-y>M")

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Implementation" })
vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { desc = "Type Definition" })

vim.keymap.set('n', '[q', '<cmd>cprev<CR>zz', { desc = 'Go to previous item in the [q]uickfix list' })
vim.keymap.set('n', ']q', '<cmd>cnext<CR>zz', { desc = 'Go to next item in the [q]uickfix list' })

vim.keymap.set('n', '[l', '<cmd>lprev<CR>zz', { desc = 'Go to previous item in the location list' })
vim.keymap.set('n', ']l', '<cmd>lnext<CR>zz', { desc = 'Go to next item in the location list' })

-- LLM Test/Code Generation
vim.keymap.set({ 'n', 'v' }, '<leader>cg', ':Gen<CR>', { desc = "[C]ode [G]enerate" })

vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set('n', '<leader>e', ':Explore<cr>', { desc = 'Explore File System' })

require('which-key').register {
  ['<leader>cb'] = { name = '[B]oilerplate', _ = 'which_key_ignore' },
}
vim.keymap.set('n', '<leader>cbs', ':-1read $HOME/.dotfiles/snippets/shell.sh<CR>5ji', { desc = 'Shell' });
vim.keymap.set('n', '<leader>cbx', ':!chmod +x %<CR>', { desc = 'Make executable' });
