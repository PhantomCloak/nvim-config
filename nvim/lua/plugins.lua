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
  use 'christianchiarulli/nvcode-color-schemes.vim'
  use {"rockyzhang24/arctic.nvim", requires = {"rktjmp/lush.nvim"}, commit = '061ac5c34dbe3ee0efd1dae81cb85bd8469ad772'}
  use 'martinsione/darkplus.nvim'

  -- Dependencies

  use 'nvim-lua/plenary.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'
  use 'jremmen/vim-ripgrep'
  use 'yamatsum/nvim-nonicons' -- The completion plugin

  -- Coding Quality Of Life
  use 'windwp/nvim-autopairs'
  use 'famiu/bufdelete.nvim'
  use 'lewis6991/gitsigns.nvim'

  use {
    'rmagatti/auto-session',
    config = function()
      require("auto-session").setup {
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/"},
      }
    end
  }
  use {
    "nvim-neotest/neotest",
    requires = {
      "Issafalcon/neotest-dotnet",
      "nvim-neotest/neotest-plenary",
      "antoinemadec/FixCursorHold.nvim"
    }
  }


  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })

  -- Navigation +++
  use 'tpope/vim-fugitive'

  --use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'nvim-treesitter/nvim-treesitter-context'
  use 'ten3roberts/qf.nvim'
  use 'ojroques/nvim-lspfuzzy'
  --use { 'nvim-telescope/telescope.nvim', tag = '0.1.0' }
  use { 'akinsho/bufferline.nvim', tag = 'v2.*' }
  --use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' , commit = '14edfee545624f238debae3d65966647be808345'}
  use 'kyazdani42/nvim-tree.lua'

  -- Interface

  use 'stevearc/dressing.nvim'
  use 'nvim-lualine/lualine.nvim'
  use 'kevinhwang91/nvim-bqf'

  -- SCM

  use 'kdheepak/lazygit.nvim'
  --use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'itchyny/vim-gitbranch'

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
  use 'Hoffs/omnisharp-extended-lsp.nvim'
  use { 'folke/trouble.nvim', requires = 'kyazdani42/nvim-web-devicons' }

  -- Treesitter

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
