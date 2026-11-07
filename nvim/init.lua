local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.smartindent=true
vim.opt.termguicolors = true
vim.opt.scrolloff = 10
vim.opt.wrap = false

vim.o.splitright = true
vim.keymap.set("n", "<leader>v", ":vs<CR>", { desc = "open new tab" })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.opt.clipboard = "unnamedplus"
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true

vim.opt.expandtab = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

require("lazy").setup({
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,

    config = function()
        require("catppuccin").setup({
            flavour = "mocha",
            transparent_background = true,

            integrations = {
                treesitter = true,
                telescope = true,
                neotree = true,
            },
        })

        vim.cmd.colorscheme("catppuccin")
    end,
  },
  {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {},
  },
  {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	lazy = false,

	config = function()
		require("neo-tree").setup({
			close_if_last_window = false,

			enable_git_status = true,
			enable_diagnostics = true,

			filesystem = {
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
					hide_gitignored = false,
				},
				follow_current_file = {
					enabled = true,
				},
				group_empty_dirs = true,
			},

			window = {
				position = "left",
				width = 30,
			},

			default_component_configs = {
				indent = {
					with_markers = true,
				},
			},
		})

		vim.keymap.set(
			"n",
			"<leader>e",
			"<cmd>Neotree toggle<CR>"
		)

		vim.keymap.set(
			"n",
			"<leader>o",
			"<cmd>Neotree focus<CR>"
		)
	end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    build = ":TSUpdate",

    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "lua",
                "vim",
                "vimdoc",
                "bash",
                "json",
                "yaml",
                "html",
                "css",
                "javascript",
                "typescript",
                "tsx",
                "python",
                "rust",
                "c",
                "cpp",
                "go",
                "commonlisp",
            },

            auto_install = true,

            highlight = {
                enable = true,
            },

            indent = {
                enable = true,
            },
        })
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
    	"nvim-lua/plenary.nvim",
    	"nvim-tree/nvim-web-devicons",
    },
    config = function()
    	local telescope = require("telescope")
    	local builtin = require("telescope.builtin")
    	telescope.setup({
    		defaults = {
    			file_ignore_patterns = {
    				"node_modules",
    				".git/",
    				"vendor",
    			},
    			layout_config = {
    				horizontal = {
    					preview_width = 0.55,
    				},
    			},
    			sorting_strategy = "ascending",
    		},
    	})
    
    	vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "find files" })
    	vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "live grep" })
    	vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "find buffers" })
    	vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "find help tags" })
    	vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "find old files" })
    end,
  },
})
