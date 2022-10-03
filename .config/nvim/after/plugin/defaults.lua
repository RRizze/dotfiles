local api = vim.api
local g = vim.g
local opt = vim.opt

opt.path:remove "/usr/include"
opt.path:append "**"
opt.wildignorecase = true
opt.wildignore:append "**/.git/*"
