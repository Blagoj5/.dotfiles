return {
  "laytan/tailwind-sorter.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-lua/plenary.nvim" },
  config = true,
  build = "cd formatter && npm ci && npm run build",
  ft = { "jsx", "tsx", "html" },
}
