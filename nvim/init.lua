local function main()
	print("Hello", io.popen("whoami"):read("*a"))

  require('packer').startup(function(use)
    use('wbthomason/packer.nvim')
    use({
	    'rose-pine/neovim',
	    as = 'rose-pine',
    })
    use({
	    'https://github.com/lifepillar/vim-solarized8.git',
	    as = 'solarized8',
    })
    use('Yggdroot/indentLine')
    use({
      'williamboman/nvim-lsp-installer',
      config = function()
        local aerial = require('aerial')
        local util = require('lspconfig.util')
        local config = require('lspconfig')

        config.tsserver.setup {
          on_attach = aerial.on_attach,
        }
        config.astro.setup {
          root_dir = util.root_pattern('.git')
        }
        config.clangd.setup {
          filetypes = {"c", "cpp", "objc", "objcpp", "cuda", "proto","hpp"},
        }
        config.vuels.setup {}
        config.pylsp.setup {
          on_attach = aerial.on_attach,
        }
        config.hls.setup {}
        config.elixirls.setup {
          cmd = { "elixir-ls" }
        }
        config.purescriptls.setup {}
        config.lua_ls.setup {
        }
        config.svelte.setup {}
        config.rnix.setup {
          on_attach = aerial.on_attach,
        }
        config.tailwindcss.setup {
        }
        config.vimls.setup {
          on_attach = aerial.on_attach,
        }
      end
    })
    use('neovimhaskell/haskell-vim')
    use('neovim/nvim-lspconfig')
    use('elixir-editors/vim-elixir')
    use('LnL7/vim-nix')
    use('othree/html5.vim')
    use('pangloss/vim-javascript')
    use({
      'evanleck/vim-svelte',
      branch = 'main'
    })
    use({
      'hrsh7th/nvim-compe',
      config = function()
        local compe = require('compe')
        compe.setup({
          enabled = true,
          autocomplete = true,
          debug = false,
          min_length = 1,
          preselect = "enable",
          throttle_time = 80,
          source_timeout = 200,
          resolve_timeout = 800,
          incomplete_delay = 400,
          max_abbr_width = 100,
          max_kind_width = 100,
          max_menu_width = 100,
          max_menu_height = 100,
          documentation = true,
          source = {
            path = true,
            buffer = true,
            calc = true,
            nvim_lsp = true,
            nvim_lua = true,
            vsnip = true,
            ultisnips = true,
            luasnip = true,
            emoji = true,
          }
        })
      end
    })
    use('nvim-lua/popup.nvim')
    use('nvim-lua/plenary.nvim')
    use({
      'nvim-telescope/telescope.nvim',
      config = function()
        local trouble = require("trouble")
        local telescope = require("telescope")

        telescope.setup({
          defaults = {
            file_sorter = require("telescope.sorters").get_fzy_sorter,
            prompt_prefix = " >",
            color_devicons = true,

            file_previewer = require("telescope.previewers").vim_buffer_cat.new,
            grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
            qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

            mappings = {
                i = {
                    ["<C-x>"] = false,
                    ["<C-q>"] = require("telescope.actions").send_to_qflist,
                    ["<c-t>"] = trouble.open_with_trouble
                },
                n = {
                    ["<c-t>"] = trouble.open_with_trouble
                }
            },
          }
        })
        telescope.load_extension("fzy_native")
      end
    })
    use('nvim-telescope/telescope-fzy-native.nvim')
    use('tpope/vim-fugitive')
    use('tpope/vim-rhubarb')
    use({
      'nvim-treesitter/nvim-treesitter',
      run = function()
        local ts_update = require('nvim-treesitter.install').update({
          with_sync = true
        })
        ts_update()
      end
    })
    use({
      'nvim-treesitter/nvim-treesitter-context',
      config = function()
        require('treesitter-context').setup({
          enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
          max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
          min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
          line_numbers = true,
          multiline_threshold = 20, -- Maximum number of lines to show for a single context
          trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
          mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
          -- Separator between context and content. Should be a single character string, like '-'.
          -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
          separator = nil,
          zindex = 20, -- The Z-index of the context window
          on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
        })
      end
    })
    use('nvim-treesitter/playground')
    use('wuelnerdotexe/vim-astro')
    use('purescript-contrib/purescript-vim')
    use({
      'prettier/vim-prettier',
      run = 'yarn install',
      ft = {
        'javascript',
        'typescript',
        'css',
        'less',
        'scss',
        'json',
        'graphql',
        'markdown',
        'vue',
        'svelte',
        'yaml',
        'html'
      },
    })
    use('rbgrouleff/bclose.vim')
    use({
      'kyazdani42/nvim-web-devicons',
      config = function()
        local devicons = require("nvim-web-devicons")
        devicons.setup {
          default = true;
        }
      end
    })
    use({
      'folke/trouble.nvim',
      config = function()
        local trouble = require("trouble")
        trouble.setup({
          mode = "document_diagnostics",
          auto_open = true
        })
      end
    })
    use({
      'stevearc/aerial.nvim',
      config = function()
        local aerial = require("aerial")
        aerial.setup({
          on_attach = function(bufnr)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>a', '<cmd>AerialToggle!<CR>', {})
            -- Jump forwards/backwards with '{' and '}'
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '{', '<cmd>AerialPrev<CR>', {})
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '}', '<cmd>AerialNext<CR>', {})
            -- Jump up the tree with '[[' or ']]'
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '[[', '<cmd>AerialPrevUp<CR>', {})
            vim.api.nvim_buf_set_keymap(bufnr, 'n', ']]', '<cmd>AerialNextUp<CR>', {})
          end
        })
      end
    })
    use('tikhomirov/vim-glsl')
  end)

  vim.cmd("filetype plugin indent on")
  vim.cmd("syntax on")
  vim.api.nvim_set_option('termguicolors', true)
  vim.cmd('colorscheme solarized8')
  vim.cmd('highlight ColorColumn ctermbg=0 guibg=grey')
  vim.cmd('hi SignColumn guibg=none')
  vim.cmd('hi CursorLineNR guibg=none')
  vim.cmd('highlight Normal guibg=none')
  vim.cmd('highlight LineNr guifg=#5eacd3')
  vim.cmd('highlight netrwDir guifg=#5eacd3')
  vim.cmd('highlight qfFileName guifg=#aed75f')
  vim.cmd('hi TelescopeBorder guifg=#5eacd')

	-- https://neovim.io/doc/user/lua.html#vim.opt
  vim.opt.background = "dark"
	vim.opt.cmdheight = 1
	vim.opt.colorcolumn = "80"
  vim.opt.completeopt = "menuone,noselect"
	vim.opt.encoding = "utf-8"
	vim.opt.expandtab = true
	vim.opt.fileencodings = "ucs-bom,utf-8,sjis,default"
	vim.opt.guicursor = ""
	vim.opt.hidden = true
	vim.opt.incsearch = true
	vim.opt.isfname:append("@-@")
	vim.opt.hlsearch = false
	vim.opt.backup = false
	vim.opt.wrap = false
	vim.opt.swapfile = false
	vim.opt.nu = true
	vim.opt.relativenumber = true
	vim.opt.scrolloff = 8
	vim.opt.shiftwidth = 2
	vim.opt.signcolumn = "yes"
	vim.opt.smartindent = true
	vim.opt.softtabstop = 2
	vim.opt.splitbelow = true
	vim.opt.splitright = true
	vim.opt.tabstop = 2
	vim.opt.undodir= vim.fn.expand('~/.vim/undodir')
	vim.opt.undofile = true
	vim.opt.updatetime = 50

	vim.g.mapleader = " "
  vim.g.haskell_enable_quantification = 1
  vim.g.haskell_enable_recursivedo = 1
  vim.g.haskell_enable_arrowsyntax = 1
  vim.g.haskell_enable_pattern_synonyms = 1
  vim.g.haskell_enable_typeroles = 1
  vim.g.haskell_enable_static_pointers = 1
  vim.g.haskell_backpack = 1
  vim.g.netrw_browse_split = 0
  vim.g.netrw_winsize = 75
  vim.g.netrw_localrmdir = "rm -r"
  vim.g.netrw_altv = 1
  vim.g['prettier#config#single_quote'] = true
  vim.g['prettier#config#tab_width'] = 2
  vim.g.vim_json_conceal = 0
  vim.g.indentLine_concealcursor= "nc"
  vim.g.move_key_modifier_visualmode = "S"

	-- https://neovim.io/doc/user/lua.html#vim.keymap
	vim.keymap.set("n", "<leader>cwdp", ":let @* = expand('%')<CR>", {
    noremap = true
  })
	vim.keymap.set("n", "<leader>cwd", ":let @* = getcwd()<CR>", {
    noremap = true
  })
	vim.keymap.set("n", "<leader>sv", ":source $MYVIMRC<CR>", {
    noremap = true
  })
	vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
	vim.keymap.set("n", "<leader>vs", ":vs<CR>", {
    noremap = true
  })
	vim.keymap.set("n", "<leader>sp", ":sp<CR>", {
    noremap = true
  })
  vim.keymap.set("n", "<leader>open", ":exe ':silent !open %'<CR>", {
    noremap = true
  })
  vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {
    noremap = true
  })
  vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, {
    noremap = true
  })
  vim.keymap.set("n", "<leader>gh", vim.lsp.buf.hover, {
    noremap = true
  })
  vim.keymap.set("n", "<leader>ge", vim.diagnostic.open_float, {
    noremap = true
  })
  vim.keymap.set("n", "<leader>gs", "<cmd>Git<CR>", {
    noremap = true
  })
  vim.keymap.set("n", "<leader>p", function() vim.cmd("Prettier") end, {
    noremap = true
  })
  vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<CR>", {
    noremap = true
  })
  vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<CR>", {
    noremap = true
  })
  vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<CR>", {
    noremap = true
  })
  vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<CR>", {
    noremap = true
  })
  vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<CR>", {
    noremap = true
  })
  vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<CR>", {
    noremap = true
  })
  vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", {
    noremap = true
  })
  vim.keymap.set("n", "<leader>fp", "<cmd>Telescope file_browser<CR>", {
    noremap = true
  })
  vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", {
    noremap = true
  })
  vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", {
    noremap = true
  })
  vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", {
    noremap = true
  })
  vim.keymap.set("n", "<leader>fs",
    function()
      local builtin = require('telescope.builtin')
      builtin.grep_string({ search = vim.fn.input("Grep > ") })
    end,
    {
      noremap = true
    }
  )
  vim.keymap.set("n", "<leader>fi",
    function()
      require("telescope.builtin").git_commits({
      })
    end,
    {
      noremap = true
    }
  )
  vim.keymap.set("n", "<leader>fv",
    function()
      require("telescope.builtin").find_files({
        prompt_tile = "< VimRc >",
        cwd = "$HOME/.config/nvim/",
      })
    end,
    {
      noremap = true
    }
  )
  vim.keymap.set("n", "<leader>fr",
    function()
      require("telescope.builtin").find_files({
        prompt_tile = "< Root >",
        cwd = "$HOME/",
      })
    end,
    {
      noremap = true
    }
  )
  vim.keymap.set("n", "<leader>fd",
    function()
      require("telescope.builtin").find_files({
        prompt_tile = "< Dumps >",
        cwd = "$HOME/Projects/tmp/dumps/",
      })
    end,
    {
      noremap = true
    }
  )
  vim.keymap.set("n", "<leader>cx",
    function()
      os.execute("chmod +x " .. vim.fn.expand("%"))
    end,
    {
      noremap = true
    }
  )

  -- https://neovim.io/doc/user/lua-guide.html#lua-guide-autocommand-create
  vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.ex,*.exs",
    callback = "set filetype=elixir"
  })
  vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.eex,*.heex,*.leex,*.sface,*.lexs",
    callback = "set filetype=eelixir"
  })
  vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "mix.lock",
    callback = "set filetype=elixir"
  })
  vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.ejs",
    callback = "set filetype=mason"
  })
  vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.eta",
    callback = "set filetype=mason"
  })
  vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = "*.vue",
    command = "PrettierAsync"
  })
  vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = "*.ts",
    command = "PrettierAsync"
  })
  vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = "*.tsx",
    command = "PrettierAsync"
  })
  vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = "*.js",
    command = "PrettierAsync"
  })
  vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = "*.jsx",
    command = "PrettierAsync"
  })
  vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = "*.json",
    command = "PrettierAsync"
  })
  vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = "*.mjs",
    command = "PrettierAsync"
  })
  vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = "*.css",
    command = "PrettierAsync"
  })
  vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = "*.less",
    command = "PrettierAsync"
  })
  vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = "*.scss",
    command = "PrettierAsync"
  })
  vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = "*.html",
    command = "PrettierAsync"
  })
end

main()
