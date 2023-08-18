-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

lvim.plugins = {
  "cpea2506/one_monokai.nvim",
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {}
  },
  "jwalton512/vim-blade",
  "nkrkv/tree-sitter-rescript",
  "rescript-lang/vim-rescript",
  "mattn/emmet-vim",
  "f-person/git-blame.nvim",
  "jparise/vim-graphql",
}

lvim.colorscheme = "one_monokai"

-- Language Support

lvim.builtin.treesitter.ensure_installed = {
  'rust',
  'php',
  'ocaml',
  'javascript',
  'typescript',
  'go',
}


local lsp_manager = require('lvim.lsp.manager')
lsp_manager.setup('rust')
lsp_manager.setup('ocaml')
lsp_manager.setup('intelephense')
lsp_manager.setup('python')
lsp_manager.setup('go')

vim.filetype.add({
  pattern = {
    ['.*%.blade%.php'] = 'blade',
    ["normie.zsh-theme"] = "shell",
  },
})

local black = '#000000'
local dev_icons = require('nvim-web-devicons')

local icon_ocaml = ""
local icon_ferris = ""

dev_icons.setup({
  override_by_filename = {
    ["dune-project"] = {
      icon = icon_ocaml,
      color = "#B294BB",
      name = "Dune",
    },
    ["dune"] = {
      icon = icon_ocaml,
      color = "#B294BB",
      name = "Dune",
    },
    ["artisan"] = {
      icon = "🎨",
      color = black,
      name = "Artisan",
    },
  },

  override_by_extension = {
    ml = {
      icon = icon_ocaml,
      color = "#F0C674",
      name = "OCaml",
    },
    -- mli = {
      -- icon = icon_ocaml,
      -- color = "#B294BB",
      -- name = "OCaml"
    -- },
    opam = {
      icon = "🏜️",
      color = "#F0C674",
      name = "Opam",
    },
    rs = {
      icon = icon_ferris,
      color = "#CC6666",
      name = "Rust",
    },
  }
})

-- Set shift width to 4 on each new buffer
vim.cmd([[autocmd BufEnter * setlocal shiftwidth=4]])
-- Set working dir to location of current buffer
-- vim.cmd([[autocmd BufEnter * setlocal autochdir]])

-- Git Blame Setup
vim.g.gitblame_display_virtual_text = 0 -- Disable virtual text
local git_blame = require('gitblame')
-- Add to bottom status bar
lvim.builtin.lualine.sections = {
  lualine_c = {
    { git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available }
  }
}

-- Formatters
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
    {
        name = "prettier",
        args = {},
        filetypes = {
            "typescript",
            "typescriptreact",
            "javascript",
            "javascriptreact",
        }
    },
    {
        name = "ocamlformat"
    },
    {
        name = "rustfmt"
    },
}

lvim.builtin.which_key.mappings['t'] = {
    '<cmd>sp|te<CR>', "Terminal"
}
