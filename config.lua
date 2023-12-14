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
    "rescript-lang/vim-rescript",
    "nkrkv/nvim-treesitter-rescript",
    "mattn/emmet-vim",
    "f-person/git-blame.nvim",
    "jparise/vim-graphql",
    "voldikss/vim-floaterm",
    "NvChad/nvim-colorizer.lua",
    "p00f/nvim-ts-rainbow",
    "axelvc/template-string.nvim",
    "almo7aya/openingh.nvim",
    {
        "rest-nvim/rest.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
             require("rest-nvim").setup({
               --- Get the same options from Packer setup
            })
          end
    }
}

lvim.colorscheme = "one_monokai"

require 'nvim-treesitter.configs'.setup {
    rainbow = {
        enable = true,
        -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        extended_mode = true,
        colors = {
            "#aaaaaa",
            "#87cefa",
            "#da70d6",
            "#f8fc94",
        },
    }
}

require('template-string').setup({
  filetypes = { 'html', 'typescript', 'javascript', 'typescriptreact', 'javascriptreact', 'python' },
  jsx_brackets = true,
  remove_template_string = false,
  restore_quotes = {
    normal = [[']],
    jsx = [["]],
  },
})

-- Language Support
lvim.builtin.treesitter.ensure_installed = {
    'rust',
    'php',
    'ocaml',
    'javascript',
    'typescript',
    'go',
    'lua',
    'python',
    'rescript',
}

local lsp_manager = require('lvim.lsp.manager')
lsp_manager.setup('rust')
lsp_manager.setup('ocaml')
lsp_manager.setup('intelephense')
lsp_manager.setup('python')
lsp_manager.setup('go')

-- Filetype Patterns
vim.cmd([[au BufNewFile,BufRead *.zsh-theme set filetype=zsh]])
vim.cmd([[au BufNewFile,BufRead *.blade.php set filetype=blade]])

local black = '#000000'
local dev_icons = require('nvim-web-devicons')
local dune_purple = "#B294BB"

local icons = {
    ocaml = "",
    ferris = "",
    terminal = "",
    art = "🎨",
    desert = "🏜️",
}

dev_icons.setup({
    override_by_filename = {
        ["dune-project"] = {
            icon = icons.ocaml,
            color = dune_purple,
            name = "Dune",
        },
        ["dune"] = {
            icon = icons.ocaml,
            color = dune_purple,
            name = "Dune",
        },
        ["artisan"] = {
            icon = icons.art,
            color = black,
            name = "Artisan",
        },
    },

    override_by_extension = {
        ml = {
            icon = icons.ocaml,
            color = "#F0C674",
            name = "OCaml",
        },
        mli = {
            icon = icons.ocaml,
            color = dune_purple,
            name = "OCaml"
        },
        ['zsh-theme'] = {
            icon = icons.terminal,
            color = "#98C379",
            name = "ZSH",
        },
        opam = {
            icon = icons.desert,
            color = "#F0C674",
            name = "Opam",
        },
        rs = {
            icon = icons.ferris,
            color = "#CC6666",
            name = "Rust",
        },
    }
})

require'colorizer'.setup()

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
    name = "+Terminal",
    h = { ":FloatermNew --wintype=normal --position=botright --height=8<CR>", "Below" },
    v = { ":FloatermNew --wintype=vsplit --position=right --height=8<CR>", "Side" },
    f = { ":FloatermNew --title=Python python3<CR>", "Python" },
    g = { ":FloatermNew --title=OCaml utop<CR>", "OCaml" },
    j = { ":FloatermNew --title=Javascript node<CR>", "Javascript" },
    d = { ":FloatermNew --title=Haskell ghci<CR>", "Haskell" },
    t = { ":FloatermToggle --title=Shell<CR>", "Popup" },
    p = { ":FloatermNew --title=Laravel --wintype=normal --position=botright --height=8 tinker<CR>", "Tinker" },
}

lvim.builtin.which_key.mappings['T'] = {}

lvim.builtin.which_key.mappings.s.p = {":Telescope projects<CR>", "Projects"}
lvim.builtin.which_key.mappings.g.w = {":OpenInGHFile<CR>", "Open on GitHub"}

-- View
lvim.builtin.which_key.mappings.v = {
    name = "+View",
    g = { ":OpenInGHFile<CR>", "View on GitHub" },
    f = { ":! nautilus %:p:h<CR>", "View in File Explorer"},
}

-- Rest
lvim.builtin.which_key.mappings.r = {
    name = "+Rest",
    r = { ":lua require('rest-nvim').run()<CR>", "Send Request"},
    p = { ":lua require('rest-nvim').run(true)<CR>", "Preview Request"},
    l = { ":lua require('rest-nvim').last()<CR>", "Last Request"},
}

vim.diagnostic.config({
  virtual_text = true
})

vim.cmd([[set relativenumber]])

-- happy_camper_dot_com
-- Make _ count as a word seperator
vim.cmd([[set iskeyword-=_]])
vim.cmd([[set ic]])

-- Show line diagnostics automatically in hover window
-- vim.o.updatetime = 250
-- vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
