-- https://neovim.io/doc/user/health.html
-- vim.cmd([[autocmd FileType checkhealth :set modifiable | silent! %s/\v( ?[^\x00-\x7F])//g]])
vim.cmd([[autocmd FileType checkhealth :set modifiable | silent! %s/✅//g]])
vim.cmd([[autocmd FileType checkhealth :set modifiable | silent! %s/⚠️//g]])
vim.cmd([[autocmd FileType checkhealth :set modifiable | silent! %s/❌//g]])
vim.cmd([[autocmd FileType checkhealth :goto]])
