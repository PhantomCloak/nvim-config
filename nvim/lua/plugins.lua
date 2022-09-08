local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})


return packer.startup(function(use)

	use({ "wbthomason/packer.nvim" })

	-- Dependencies

	use({ "nvim-lua/plenary.nvim" }) 
	use({ "kyazdani42/nvim-web-devicons" })
	use({ "jremmen/vim-ripgrep" }) 
	use({ "yamatsum/nvim-nonicons"}) -- The completion plugin
	
	-- Coding Quality Of Life

	use({ "windwp/nvim-autopairs", commit = "a7a8be3d2f2473300d070293903ac8b95edeccc1" }) 

	-- Navigation +++

	use({ "kyazdani42/nvim-tree.lua" })
	use({ "romgrk/barbar.nvim" })
	use({ "SmiteshP/nvim-navic" }) 
	use ({'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons'})
    use ({'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'})
	use ({ "nvim-treesitter/nvim-treesitter-textobjects", requires = "kyazdani42/nvim-web-devicons"})
	use({ "ten3roberts/qf.nvim" }) 

	-- Interface

	use({ "Shatur/neovim-ayu" })
	use({ "stevearc/dressing.nvim" }) -- The completion plugin
	use({ "nvim-lualine/lualine.nvim" })
	use({ "kevinhwang91/nvim-bqf"}) 

	-- SCM

	use({ "kdheepak/lazygit.nvim", commit = "9c73fd69a4c1cb3b3fc35b741ac968e331642600" }) -- The completion plugin
	
	-- LSP

	use({ "neovim/nvim-lspconfig", commit = "568aa4d41e1150823ce8e5cbdea47278d3fddf36" }) -- enable LSP
	use({ "hrsh7th/cmp-nvim-lsp", commit = "affe808a5c56b71630f17aa7c38e15c59fd648a8" }) 
	use({ "hrsh7th/nvim-cmp", commit = "b1ebdb0a17daaad13606b802780313a32e59781b" }) 
	use({ "ray-x/lsp_signature.nvim", commit = "e65a63858771db3f086c8d904ff5f80705fd962b" }) -- The completion plugin
	
	-- DAP

	use({ "mfussenegger/nvim-dap" })
	use({ "rcarriga/nvim-dap-ui" })

	-- LSP Related
	use({ "folke/lsp-colors.nvim" }) 
	use({ "onsails/lspkind.nvim" }) 
	use({ "lukas-reineke/lsp-format.nvim" }) 
	use({ "wfxr/minimap.vim" }) 
	use({ "williamboman/mason.nvim" }) 
	use({ "Hoffs/omnisharp-extended-lsp.nvim" }) 
	use { "folke/trouble.nvim", requires = "kyazdani42/nvim-web-devicons"}

	-- Telescope

	use { 'nvim-telescope/telescope.nvim', tag = '0.1.0', requires = { {'nvim-lua/plenary.nvim'} }}
	use({ "gbrlsnchs/telescope-lsp-handlers.nvim" }) 
	use { "LinArcX/telescope-command-palette.nvim" }

	-- Treesitter

	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
