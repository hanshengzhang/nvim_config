require("config.lazy")

-- 显示行号
vim.opt.number = true

-- 使用系统剪贴板（使得普通模式下的 `y` 复制到系统剪贴板）
vim.opt.clipboard = "unnamedplus"

-- 保存并记录最近打开的文件（依赖 Neovim 自带的 shada 机制）
-- 下面这一行主要是调大可记录的文件数量（'1000 表示最多 1000 个文件）
vim.opt.shada = "!,'1000,<50,s10,h"

-- 快速打开最近使用的文件列表
-- 现在由 Telescope 提供（在 lua/plugins/telescope.lua 中配置 <leader>fr）
