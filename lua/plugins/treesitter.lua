return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master", -- 使用兼容 ts_utils 的旧版分支
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				-- 安装一些常用解析器，包含 markdown，提升 Vimwiki 的高亮
				ensure_installed = {
					"lua",
					"vim",
					"vimdoc",
					"markdown",
					"markdown_inline",
				},
				highlight = {
					enable = true,
					-- 让 markdown 继续保留基于正则的补充高亮（包括 Vimwiki / 其他插件）
					additional_vim_regex_highlighting = { "markdown" },
				},
				indent = { enable = true },
			})
		end,
	},
}
