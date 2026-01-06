return {
	{
		"lervag/vimtex",
			ft = { "tex", "plaintex", "latex" },
			init = function()
				-- 使用 latexmk 作为默认编译器
				vim.g.vimtex_compiler_method = "latexmk"
				-- 告诉 vimtex 使用 xelatex 作为编译引擎
				vim.g.vimtex_compiler_engine = "xelatex"
				-- 告诉 latexmk 默认使用 xelatex
				vim.g.vimtex_compiler_latexmk_engines = {
					_ = "-xelatex",
				}
				-- 使用 xelatex 作为 latexmk 的默认引擎参数
				vim.g.vimtex_compiler_latexmk = {
					continuous=0,
					options = {
						"-xelatex",
						"-file-line-error",
						"-synctex=1",
						"-interaction=nonstopmode",
					},
				}
				-- 编码设置
				vim.g.vimtex_encoding = "utf-8"
				-- 自动打开 quickfix
				vim.g.vimtex_quickfix_mode = 0
				-- LaTeX 文件缩进和按键映射（仅在 TeX 缓冲区生效）
				vim.api.nvim_create_autocmd("FileType", {
					pattern = { "tex", "plaintex", "latex" },
					callback = function()
						-- 缩进 2 空格
						vim.bo.shiftwidth = 2
						vim.bo.tabstop = 2
						vim.bo.softtabstop = 2
						vim.bo.expandtab = true

						-- 仅在 TeX buffer 中生效的保存+编译快捷键
						vim.keymap.set("n", "<leader>lc", function()
							vim.cmd("w")
							vim.cmd("VimtexCompile")
						end, { buffer = true, silent = true, desc = "保存并编译 LaTeX" })
					end,
				})

				-- macOS 下常用的 PDF 查看器配置：Skim
				-- 如果你用的是其他 PDF 阅读器，可以之后再调整
				vim.g.vimtex_view_method = "skim"
				vim.g.vimtex_view_skim_sync = 1
				vim.g.vimtex_view_skim_activate = 1
		end,
	},
}
