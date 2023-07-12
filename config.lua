-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
--

-- Plugins
lvim.plugins = {
  "cpea2506/one_monokai.nvim"
}

lvim.colorscheme = "one_monokai"

-- Language Support

lvim.builtin.treesitter.ensure_installed = {
  'rust',
  'php',
  'javascript',
  'typescript',
}

local lsp_languages = {
  "rust",
  "ocaml",
  "intelephense", -- PHP
}

local lsp_manager = require('lvim.lsp.manager')
for _, lang in ipairs(lsp_languages) do
  lsp_manager.setup(lang)
end
