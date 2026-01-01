-- In your lazy.nvim plugins/vimwiki.lua or equivalent file

return {
	"vimwiki/vimwiki", -- The plugin repository
	event = "BufReadPre *.wiki", -- 只在 .wiki 文件时加载
	-- OR `event = "VeryLazy"` for loading on demand

	-- Use `init` to set global variables before the plugin loads
	init = function()
		vim.g.vimwiki_list = {
			{
				path = "~/vimwiki/", -- Your wiki's root directory
				syntax = "default", -- 使用 Vimwiki 自带语法
				ext = ".wiki", -- 使用 .wiki 作为扩展名
			},
		}

		-- 明确指定后缀和语法的映射关系（可选，但更清晰）
		vim.g.vimwiki_ext2syntax = {
			[".wiki"] = "default",
		}

		-- 使用 Vimwiki 推荐的基于表达式的折叠（按标题层级折叠）
		vim.g.vimwiki_folding = "expr"
	end,

	-- `config` is for setup *after* loading, often for keymaps
	config = function()
		-- Keymaps for navigating your wiki
		vim.keymap.set("n", "<leader>ww", "<cmd>VimwikiIndex<cr>", { desc = "Open Vimwiki Index" })
		vim.keymap.set("n", "<leader>wt", "<cmd>VimwikiToHtml<cr>", { desc = "Vimwiki To HTML" })
		-- Add more keymaps as desired, like opening a specific wiki
		-- vim.keymap.set("n", "<leader>wW", "<cmd>VimwikiDiaryIndex<cr>", { desc = "Open Vimwiki Diary" })

		-- 自定义 Vimwiki 高亮，让不同元素用不同颜色/样式
		local function set_vimwiki_highlights()
			local set_hl = vim.api.nvim_set_hl

			-- 不同级别标题使用不同的高亮组
			-- 一级标题：使用固定的明亮金色并加粗，提高对比度
			set_hl(0, "VimwikiHeader1", { fg = "#FFD700", bold = true })
			-- 二级标题：亮一点的天蓝色并加粗
			set_hl(0, "VimwikiHeader2", { fg = "#87CEFA", bold = true })
			set_hl(0, "VimwikiHeader3", { link = "Identifier" })
			set_hl(0, "VimwikiHeader4", { link = "Function" })
			set_hl(0, "VimwikiHeader5", { link = "Type" })
			set_hl(0, "VimwikiHeader6", { link = "Statement" })

			-- 链接 / 代码 / 列表 / TODO 等元素
			set_hl(0, "VimwikiLink", { link = "Underlined" })
			set_hl(0, "VimwikiCode", { link = "String" })
			set_hl(0, "VimwikiList", { link = "Special" })
			set_hl(0, "VimwikiTodo", { link = "Todo" })
			-- DONE 专用：高亮为绿色，但保持 TODO 不变
			set_hl(0, "VimwikiDone", { fg = "#00FF00", bold = true })

			-- 粗体 / 斜体 结合颜色
			set_hl(0, "VimwikiBold", { bold = true, link = "Special" })
			set_hl(0, "VimwikiItalic", { italic = true, link = "Comment" })
		end

		-- 在进入 Vimwiki buffer 时应用高亮和折叠设置
		local group = vim.api.nvim_create_augroup("VimwikiFancyHighlight", { clear = true })
		vim.api.nvim_create_autocmd("FileType", {
			group = group,
			pattern = "vimwiki",
			callback = function()
				set_vimwiki_highlights()
				-- 打开 buffer 时，所有层级默认展开，只保留折叠功能
				-- 这样 1 级和 2 级标题都可以自由折叠/展开
				vim.opt_local.foldenable = true
				vim.opt_local.foldlevel = 99
			end,
		})
	end,
}
