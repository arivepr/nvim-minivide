return {
  {
    "echasnovski/mini.icons",
    opts = {},
    lazy = true,
    specs = {
      { provider = "mini.icons", setup = function() require("mini.icons").setup() end },
    },
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },
}
