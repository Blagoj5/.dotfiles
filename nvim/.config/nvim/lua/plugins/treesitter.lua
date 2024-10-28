return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TsUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    }
  },
  { "nvim-treesitter/nvim-treesitter-context" }
}
