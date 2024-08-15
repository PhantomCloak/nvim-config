local fn = vim.fn




return packer.startup(function(use)

  use 'wbthomason/packer.nvim'
  -- COLORS
  use {"rockyzhang24/arctic.nvim", requires = {"rktjmp/lush.nvim"}, commit = '061ac5c34dbe3ee0efd1dae81cb85bd8469ad772'}
  use 'Mofiqul/vscode.nvim'


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
  use 'nvimdev/lspsaga.nvim'
  use 'RaafatTurki/hex.nvim'
  use 'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim'
  use {
  'nmac427/guess-indent.nvim',
  config = function() require('guess-indent').setup {} end,
}

  use {
    'folke/persistence.nvim',
    config = function()
      require("persistence").setup {
        event = "BufReadPre"
      }
    end
  }

--  use({
--    "iamcco/markdown-preview.nvim",
--    run = function() vim.fn["mkdp#util#install"]() end,
--})


  -- Navigation +++
  use 'tpope/vim-fugitive'
  use 'Decodetalkers/csharpls-extended-lsp.nvim'

  --use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'ten3roberts/qf.nvim'
  use 'ojroques/nvim-lspfuzzy'
  use { 'akinsho/bufferline.nvim', tag = 'v2.*' }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  --use {'nvim-treesitter/nvim-treesitter-context', requires = 'nvim-treesitter/nvim-treesitter'}
  use 'kyazdani42/nvim-tree.lua'

  -- Interface

  use 'stevearc/dressing.nvim'
  use 'nvim-lualine/lualine.nvim'
  use 'kevinhwang91/nvim-bqf'
  
  -- SCM

  use 'kdheepak/lazygit.nvim'
  use 'tpope/vim-rhubarb'
  use 'tpope/vim-fugitive'
  use 'itchyny/vim-gitbranch'

  -- LSP

  use {'neovim/nvim-lspconfig'}
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/nvim-cmp'
  use 'ray-x/lsp_signature.nvim'
  use { "pmizio/typescript-tools.nvim", dependencies = { "nvim-lua/plenary.nvim" }}

  -- DAP


  use 'nvim-neotest/nvim-nio'
  use 'mfussenegger/nvim-dap'
  use 'rcarriga/nvim-dap-ui'
  use 'lommix/godot.nvim'

  -- LSP Related

  use 'onsails/lspkind.nvim'
  use 'lukas-reineke/lsp-format.nvim'
  use 'Hoffs/omnisharp-extended-lsp.nvim'
  use { 'folke/trouble.nvim', requires = 'kyazdani42/nvim-web-devicons' }

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
