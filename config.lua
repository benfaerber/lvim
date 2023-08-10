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
}


local lsp_manager = require('lvim.lsp.manager')
lsp_manager.setup('rust')
lsp_manager.setup('ocaml')
lsp_manager.setup('intelephense')
lsp_manager.setup('python')

vim.filetype.add({
  pattern = {
    ['.*%.blade%.php'] = 'blade',
    [".*%.zsh-theme"] = "shell",
  },
})

local black = '#000000'
local dev_icons = require('nvim-web-devicons')

local icon_ocaml = ""
local icon_ferris = ""

dev_icons.setup({
  override_by_filename = {
    ["dune-project"] = {
      icon = "🏜️",
      color = black,
      name = "Dune",
    },
    ["dune"] = {
      icon = "🏜️",
      color = black,
      name = "Dune",
    },
    ["artisan"] = {
      icon = "🎨",
      color = black,
      name = "Artisan",
    },

    ["docker-composer.yml"] = {
      icon = "🐳",
      color = black,
      name = "Docker",
    },

    ["Dockerfile"] = {
      icon = "🐳",
      color = black,
      name = "Docker",
    },

  },

  override_by_extension = {
    ml = {
      icon = icon_ocaml,
      color = "#F0C674",
      name = "OCaml",
    },
    opam = {
      icon = "🏜️",
      color = black,
      name = "OPAM",
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
vim.cmd([[autocmd BufEnter * setlocal autochdir]])

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


