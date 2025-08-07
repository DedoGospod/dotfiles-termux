-- Plugin setup with lazy.nvim
require("lazy").setup({
    spec = {
        { import = "plugins" },
        { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    },
    checker = { enabled = true },
})

require("config.keymaps") -- keymaps

-- Neotree configuration
require('neo-tree').setup({
    window = {
        auto_expand_width = true,
    },
    filesystem = {
        filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = true,
        },
    },
})

-- nvim-treesitter configuration
require("nvim-treesitter.configs").setup({
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true,
    },
    ensure_installed = {
        "json", "javascript", "typescript", "tsx", "yaml", "html", "css", "markdown",
        "markdown_inline", "bash", "lua", "vim", "dockerfile", "c", "c_sharp", "cpp",
        "rust", "go", "hyprlang", "python", "zig",
    },
})

-- Telescope configuration
require('telescope').load_extension('fzf')
require('telescope').setup {
    defaults = {
        vimgrep_arguments = {
            'rg',                            -- invoke ripgrep
            '--color=never',                 -- disable colored output
            '--no-heading',                  -- suppresses the printing of file headings
            '--with-filename',               -- always prints the file name for each match
            '--line-number',                 -- prints the 1-based line number for each match
            '--column',                      -- prints the 1-based column number for the start of each match
            '--smart-case',                  -- performs a case-insensitive search if the pattern contains no uppercase letters, and a case-sensitive search otherwise
            '--hidden',                      -- searches hidden files and directories
        },
    },
    pickers = {
        find_files = { hidden = true },      -- find hidden files
    },
    extensions = {
        fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- "smart_case", "ignore_case" or "respect_case"
        }
    }
}

-- Nvim autopairs
require('nvim-autopairs').setup({
  check_ts = true,
})

-- harpoon
local harpoon = require('harpoon')
harpoon:setup({})

-- Snippets
--require('luasnip.loaders.from_vscode').lazy_load()
--require('luasnip.loaders.from_snipmate').lazy_load()

-- LSP lines setup
--require("lsp_lines").setup()

require("lualine").setup()