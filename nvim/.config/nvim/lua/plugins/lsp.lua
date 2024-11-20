-- https://lsp-zero.netlify.app/docs/getting-started
return {
  {
    -- Manages language servers
    "williamboman/mason.nvim",
    lazy = false,
    opts = {},
  },
  {
    -- Completion engine extension
    -- https://github.com/hrsh7th/nvim-cmp
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        sources = {
          {name = "nvim_lsp", max_item_count = 7},
        },
        preselect = "item",
        completion = {
          completeopt = "menu,menuone,noinsert"
        },
        mapping = cmp.mapping.preset.insert({
          ["<CR>"] = cmp.mapping.confirm({select = false}),
          ["<Tab>"] = cmp.mapping.select_next_item({behavior = "select"}),
          ["<S-Tab>"] = cmp.mapping.select_prev_item({behavior = "select"}),
        }),
      })
    end
  },
  {
    -- LSP client configurations
    -- https://github.com/neovim/nvim-lspconfig
    "neovim/nvim-lspconfig",
    cmd = {"LspInfo", "LspInstall", "LspStart"},
    event = {"BufReadPre", "BufNewFile"},
    dependencies = {
      {"hrsh7th/cmp-nvim-lsp"},
      {"williamboman/mason.nvim"},
      {"williamboman/mason-lspconfig.nvim"},
    },
    config = function()
      local lsp_defaults = require("lspconfig").util.default_config

      lsp_defaults.capabilities = vim.tbl_deep_extend(
      "force",
      lsp_defaults.capabilities,
      require("cmp_nvim_lsp").default_capabilities()
      )

      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP actions",
        callback = function(event)
          local opts = {buffer = event.buf}

          vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
          vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
          vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
          vim.keymap.set("n", "gt", function() vim.lsp.buf.type_definition() end, opts)
          vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
          vim.keymap.set("n", "ga", function() vim.lsp.buf.code_action() end, opts)
          vim.keymap.set("n", "<leader>ws", function() vim.lsp.buf.workspace_symbol() end, opts)
          vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
          vim.keymap.set("n", "<leader>=", function() vim.lsp.buf.format() end, opts)
          vim.keymap.set("n", "<leader>ll", function() vim.diagnostic.open_float() end, opts)
          vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        end,
      })

      require("mason-lspconfig").setup({
        ensure_installed = {},
        handlers = {
          function(server_name)
            require("lspconfig")[server_name].setup({})
          end,
        }
      })

      vim.diagnostic.config({
        virtual_text = false,
        signs = true,
        update_in_insert = false,
        underline = true,
        severity_sort = false,
        float = true,
      })
    end
  }
}
