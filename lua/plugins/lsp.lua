return {
  -- LSP Configuration & Plugins
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "folke/neodev.nvim",
    },
    config = function()
      require("neodev").setup()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "rust_analyzer",
        },
      })

      -- Shared on_attach function
      local on_attach = function(_, bufnr)
        local nmap = function(keys, func, desc)
          if desc then
            desc = "LSP: " .. desc
          end
          vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
        end

        nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
        nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
        nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
        nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
        nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
        nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

        nmap("K", vim.lsp.buf.hover, "Hover Documentation")
        nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
        nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
      end

      -- NOTE: We do NOT call lspconfig.rust_analyzer.setup() here
      -- because rustaceanvim handles it automatically.
      -- If you add other LSPs (like pyright, tsserver), add them here:
      -- require('lspconfig').pyright.setup({ on_attach = on_attach })
    end,
  },

  {
    'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
    lazy = false, -- This plugin is already lazy
    config = function()
      vim.g.rustaceanvim = {
        server = {
          on_attach = function(_, bufnr)
            local nmap = function(keys, func, desc)
              if desc then
                desc = "LSP: " .. desc
              end
              vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
            end

            -- Keybindings for Rust
            nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
            nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
            nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
            nmap("K", vim.lsp.buf.hover, "Hover Documentation")
            nmap("<leader>ca", function() vim.cmd.RustLsp('codeAction') end, "Rust Code Action")
          end,
        },
      }
    end
  }
}
