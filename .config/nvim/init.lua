vim.g.clipboard = {
  name = 'OSC 52',
  copy = {
    ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
    ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
  },
  paste = {
    ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
    ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
  },
}

if vim.env.TMUX ~= nil then
  local copy = {'tmux', 'load-buffer', '-w', '-'}
  local paste = {'bash', '-c', 'tmux refresh-client -l && sleep 0.05 && tmux save-buffer -'}
  vim.g.clipboard = {
    name = 'tmux',
    copy = {
      ['+'] = copy,
      ['*'] = copy,
    },
    paste = {
      ['+'] = paste,
      ['*'] = paste,
    },
    cache_enabled = 0,
  }
end

local rt_paths = vim.split(vim.o.runtimepath, ",")
table.insert(rt_paths, 1, vim.fn.expand("~/.vim"))
table.insert(rt_paths, vim.fn.expand("~/.vim/after"))
vim.o.runtimepath = table.concat(rt_paths, ",")
vim.o.packpath = vim.o.runtimepath

vim.cmd("source ~/.vimrc")
