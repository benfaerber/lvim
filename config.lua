-- Master for life!
-- I will never be a cuck and use main!

-- I save the folder that was initially opened because its most likely a project root
local project_root = vim.fn.expand("%")

lvim.plugins = {
    "cpea2506/one_monokai.nvim",
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {}
    },
    "3rd/image.nvim",
    "jwalton512/vim-blade",
    "rescript-lang/vim-rescript",
    "nkrkv/nvim-treesitter-rescript",
    "mattn/emmet-vim",
    "f-person/git-blame.nvim",
    "jparise/vim-graphql",
    "voldikss/vim-floaterm",
    "NvChad/nvim-colorizer.lua",
    "echasnovski/mini.nvim",
    "p00f/nvim-ts-rainbow",
    "axelvc/template-string.nvim",
    "almo7aya/openingh.nvim",
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {},
    },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {},
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
    'c_sharp',
}

local lsp = require('lvim.lsp.manager')
lsp.setup('rust')
lsp.setup('ocaml')
lsp.setup('intelephense')
lsp.setup('javascript')
lsp.setup('typescript')
lsp.setup('python')
lsp.setup('go')
lsp.setup('c_sharp')

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

require 'colorizer'.setup()


vim.cmd([[
  augroup FiletypeShiftwidth
    autocmd!
    autocmd FileType * setlocal shiftwidth=4
    autocmd FileType ocaml setlocal shiftwidth=2
    autocmd FileType python setlocal shiftwidth=4
    autocmd FileType go setlocal shiftwidth=2
    autocmd FileType javascript,typescript setlocal shiftwidth=4
    autocmd FileType rust setlocal shiftwidth=4
  augroup END
]])
-- Set shift width to 4 on each new buffer
-- vim.cmd([[autocmd BufEnter * setlocal shiftwidth=2]])
-- Set working dir to location of current buffer
-- vim.cmd([[autocmd BufEnter * setlocal autochdir]])

-- Git Blame Setup
vim.g.gitblame_display_virtual_text = 0 -- Disable virtual text
local git_blame = require('gitblame')
-- Add to bottom status bar
lvim.builtin.lualine.sections = {
    lualine_c = {
        {
            git_blame.get_current_blame_text,
            cond = git_blame.is_blame_text_available,
        }
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
    n = { ":! alacritty --working-directory \"%:p:h\" &<CR>", "Open in Terminal in new window" },
}

lvim.builtin.which_key.mappings['T'] = {}

lvim.builtin.which_key.mappings.s.p  = { ":Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings.g.w  = { ":OpenInGHFile<CR>", "Open on GitHub" }

local run_cmd_bg                     = function(cmd)
    vim.cmd(":silent !" .. cmd .. " &")
end

-- This opens the current file (respecting line and column) in VSCode
local open_in_vscode                 = function()
    local filepath = vim.fn.expand("%")
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    -- To account for insert mode cursor vs normal cursor
    local offset_col = col + 2
    local goto_point = filepath .. ":" .. line .. ":" .. offset_col
    run_cmd_bg("code \"" .. project_root .. "\" --new-window --goto \"" .. goto_point .. "\"")
end

local open_in_nautilus               = function()
    local dir = vim.fn.expand("%")
    run_cmd_bg("nautilus " .. dir)
end

local get_dir                        = function(filepath)
    return string.match(filepath, "^(.-)/[^/]*$")
end

local get_file                       = function(filepath)
    return string.match(filepath, "^.+/([^/]+)$")
end

local open_in_alacritty              = function()
    local dir = get_dir(vim.fn.expand("%"))
    run_cmd_bg("alacritty --working-directory " .. dir)
end

local open_in_browser                = function(url)
    vim.fn.system("xdg-open " .. url)
end

local open_project_in_github         = function()
    local repo_url = vim.fn.system("git -C " .. project_root .. " config --get remote.origin.url")
    open_in_browser(repo_url)
end

local trim                           = function(s)
    return s:gsub("%s+", "")
end

local log                            = function(msg)
    os.execute("echo \"[DEBUG $(date +\"%Y-%m-%d %H:%M:%S\")] " .. msg .. "\" >> /home/ben/.config/lvim/debug.log")
end

local open_pull_request_in_github    = function()
    local repo_url = vim.fn.system("git -C " .. project_root .. " config --get remote.origin.url")
    -- This usually ends with git
    local naked_repo_url = trim(repo_url):gsub('.git$', "")

    local branch_name = trim(vim.fn.system("git rev-parse --abbrev-ref HEAD"))
    local master_path = trim(vim.fn.system("git symbolic-ref refs/remotes/origin/HEAD"))

    local pr_url = naked_repo_url .. "/compare/" .. branch_name
    open_in_browser(pr_url)
end

local Slumber                        = {}
Slumber.toggle                       = function()
    local Terminal = require("toggleterm.terminal").Terminal
    local slumber = Terminal:new {
        cmd = "slumber",
        hidden = true,
        direction = "float",
        float_opts = {
            border = "none",
            width = 100000,
            height = 100000,
        },
        on_open = function(_)
            vim.cmd "startinsert!"
        end,
        on_close = function(_) end,
        count = 99,
    }
    slumber:toggle()
end

local open_pull_request_in_github = function ()
    local repo_url = vim.fn.system("git -C " .. project_root .. " config --get remote.origin.url")
    repo_url = repo_url:gsub("%.git%s*$", "")
    local branch = vim.fn.system("git -C " .. project_root .. " rev-parse --abbrev-ref HEAD")
    branch = vim.trim(branch)

    local merge_url = repo_url .. "/compare/master..." .. branch
    vim.fn.system("xdg-open " .. merge_url)
end

-- View
lvim.builtin.which_key.mappings.v    = {
    name = "+View",
    w = { Slumber.toggle, "Open in Slumber" },
    g = { ":OpenInGHFile<CR>", "View on File on GitHub" },
    h = { open_project_in_github, "View Project on GitHub" },
    r = { open_pull_request_in_github, "Open PR on GitHub" },
    f = { open_in_nautilus, "View in File Explorer" },
    t = { open_in_alacritty, "Open in Terminal" },
    s = { open_in_vscode, "Open in VSCode" },
}

lvim.builtin.which_key.mappings.x = {
    name ="+Trouble",
    x = { ":Trouble diagnostics toggle<CR>", "View Diagnostics"},
    q = { ":Trouble qflist toggle<CR>", "Quick Fix List"},
    t = { ":Trouble todo toggle<CR>", "View Todos"},
}

vim.diagnostic.config({
    virtual_text = true
})

vim.cmd([[set relativenumber]])

-- happy_camper_dot_com
-- Make _ count as a word seperator
vim.cmd([[set iskeyword-=_]])
-- Case insensitive search
vim.cmd([[set ic]])

-- Basic spell check:
vim.cmd([[au BufNewFile,BufRead *.md setlocal spell spelllang=en_us]])
vim.cmd([[au BufNewFile,BufRead *.txt setlocal spell spelllang=en_us]])
vim.cmd([[au BufNewFile,BufRead *.php setlocal spell spelllang=en_us]])

require('mason-lspconfig').setup_handlers({
  function(server)
    require('lvim.lsp.manager').setup(server)
  end
})
-- Show line diagnostics automatically in hover window vim.o.updatetime = 250
-- vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
