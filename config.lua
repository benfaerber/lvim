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
  "jwalton512/vim-blade"

}

lvim.colorscheme = "one_monokai"

-- Language Support

lvim.builtin.treesitter.ensure_installed = {
  'rust',
  'php',
  'ocaml',
  'javascript',
  'typescript',
  'blade',
}

local lsp_languages = {
  "rust",
  "ocaml",
  "intelephense", -- PHP
  "python",
}

local lsp_manager = require('lvim.lsp.manager')
for _, lang in ipairs(lsp_languages) do
  lsp_manager.setup(lang)
end


local dev_icons = require('nvim-web-devicons')

vim.filetype.add({
  pattern = {
    ['.*%.blade%.php'] = 'blade',
  },
})

local black = '#000000'
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
  },

  override_by_extension = {
    ml = {
      icon = "🐫",
      color = black,
      name = "OCaml",
    },
    opam = {
      icon = "🏜️",
      color = black,
      name = "OPAM",
    },
    rs = {
      icon = "🦀",
      color = black,
      name = "Rust",
    },
    php = {
      icon = "🐘",
      color = black,
      name = "PHP",
    }
  }
})
