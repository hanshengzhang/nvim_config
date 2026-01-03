return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		-- 使用 Telescope 模糊搜索最近打开的文件
		keys = {
			{
				"<leader>fr",
				function()
					require("telescope.builtin").oldfiles()
				end,
				desc = "最近打开的文件（可模糊搜索）",
			},
		},
	},
}

