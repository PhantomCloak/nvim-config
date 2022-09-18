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

	use 'wbthomason/packer.nvim' 
	use 'lewis6991/impatient.nvim'

    -- COLORS
    use 'rmehri01/onenord.nvim'
    use "EdenEast/nightfox.nvim"
    use 'navarasu/onedark.nvim'
    use 'Mofiqul/vscode.nvim'
    use 'nvim-treesitter/playground'
	-- Dependencies

	use 'nvim-lua/plenary.nvim'  
	use 'kyazdani42/nvim-web-devicons' 
	use 'jremmen/vim-ripgrep'  
	use 'yamatsum/nvim-nonicons' -- The completion plugin

    -- Coding Quality Of Life
use('mrjones2014/smart-splits.nvim')
    use 'windwp/nvim-autopairs'
    use 'saadparwaiz1/cmp_luasnip'
    use({"L3MON4D3/LuaSnip", tag = "v<CurrentMajor>.*"})
    use 'rafamadriz/friendly-snippets'
    use 'famiu/bufdelete.nvim'
    use 'Hvassaa/sterm.nvim'
    use {
        'phaazon/hop.nvim',
        branch = 'v2'
    }
    use {
        'ojroques/nvim-lspfuzzy',
        requires = {
            {'junegunn/fzf'},  -- to enable preview (optional)
            {'junegunn/fzf.vim'},  -- to enable preview (optional)
        },
}

use 'itmecho/neoterm.nvim'


--use {"akinsho/toggleterm.nvim", tag = '*', config = function()
--  require("toggleterm").setup()
--end}

-- Navigation +++

use 'kyazdani42/nvim-tree.lua' 
use 'SmiteshP/nvim-navic'  
use { 'akinsho/bufferline.nvim', tag = 'v2.*' }
use { 'nvim-treesitter/nvim-treesitter', run = 'TSUpdate' }
use  'nvim-treesitter/nvim-treesitter-textobjects'
use 'nvim-treesitter/nvim-treesitter-context'
use 'ten3roberts/qf.nvim'  
use {
	'nvim-telescope/telescope.nvim', tag = '0.1.0',
	-- or                            , branch = '0.1.x',
	requires = { {'nvim-lua/plenary.nvim'} }
}
-- Interface

use 'Shatur/neovim-ayu' 
use 'stevearc/dressing.nvim'  
use 'nvim-lualine/lualine.nvim' 
use 'kevinhwang91/nvim-bqf' 

-- SCM

	use 'kdheepak/lazygit.nvim'
	use 'tpope/vim-fugitive'
	use 'tpope/vim-rhubarb'
	use 'itchyny/vim-gitbranch'
	use 'airblade/vim-gitgutter'
	
	-- LSP

	use 'neovim/nvim-lspconfig' 
	use 'hrsh7th/cmp-nvim-lsp'  
	use 'hrsh7th/nvim-cmp'  
	use 'ray-x/lsp_signature.nvim'  
	
	-- DAP

	use 'mfussenegger/nvim-dap' 
	use 'rcarriga/nvim-dap-ui' 

	-- LSP Related
	
	use 'folke/lsp-colors.nvim'  
	use 'onsails/lspkind.nvim'  
	use 'lukas-reineke/lsp-format.nvim'  
	use 'williamboman/mason.nvim'  
	use 'Hoffs/omnisharp-extended-lsp.nvim'  
	use { 'folke/trouble.nvim', requires = 'kyazdani42/nvim-web-devicons'}

	-- Treesitter

	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
