-- general options
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.termguicolors = true

vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.showmode = true 
vim.opt.cursorline = true
vim.opt.scrolloff = 3

vim.cmd('colorscheme slate')
syntax = on

-- all functions & autocommands
vim.schedule(function()
    vim.opt.clipboard = 'unnamedplus'
end)

vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end
})

vim.api.nvim_create_user_command('RunBuild', function()
  vim.cmd('cexpr system("./build.sh")')

  local exit_code = vim.v.shell_error

  if exit_code == 0 then
    print("Compilation succeeded!")
  else
    print("Compilation failed with error code:", exit_code)
    vim.cmd('copen')
  end
end, {})

vim.api.nvim_create_user_command('Grep', function(opts)
  local result = vim.fn.system('grep -rn ' .. opts.args)

  if vim.v.shell_error ~= 0 then
    print("Grep failed: " .. result)
    return
  end

  vim.fn.setqflist({}, 'r', { title = 'Grep Results', lines = vim.split(result, '\n') })

  vim.cmd('copen')
end, { nargs = '+' })

vim.api.nvim_create_user_command('Find', function(opts)
  local result = vim.fn.system('find ' .. opts.args)

  if vim.v.shell_error ~= 0 then
    print("Find failed: " .. result)
    return
  end

  local qf_lines = {}
  for _, line in ipairs(vim.split(result, '\n')) do
    if line ~= '' then
      table.insert(qf_lines, line .. ':1:0')
    end
  end

  vim.fn.setqflist({}, 'r', {
    title = 'Find Results: ' .. opts.args,
    lines = qf_lines,
    quickfixtextfunc = 'v:lua.require"vim".qflist'
  })

  if #qf_lines > 0 then
    vim.cmd('copen')
    print("Found " .. #qf_lines .. " files")
  else
    print("No files found")
  end
end, { nargs = '+' })

-- keymaps
vim.api.nvim_set_keymap('n', '<Esc>', ':nohls<CR><Esc>', { noremap = true, silent = true })
