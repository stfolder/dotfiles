return {
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,

    config = function()
      require("catppuccin").setup({
        transparent_background = true,
        color_overrides = {
          mocha = {
            rosewater = "#DAD6EB",
            flamingo = "#E6A6D7",
            pink = "#E6A6D7",
            mauve = "#B69CFF",
            red = "#F2778F",
            maroon = "#F2778F",
            peach = "#EF9F76",
            yellow = "#E7BD78",
            green = "#9ECE8A",
            teal = "#74D3C4",
            sky = "#7DCFFF",
            sapphire = "#82AAFF",
            blue = "#82AAFF",
            lavender = "#A9A0FF",
            text = "#DAD6EB",
            subtext1 = "#AAA3BF",
            subtext0 = "#81799C",
            overlay2 = "#81799C",
            overlay1 = "#665D82",
            overlay0 = "#4A4167",
            surface2 = "#4A4167",
            surface1 = "#37304F",
            surface0 = "#28243A",
            base = "#1D1A2B",
            mantle = "#171522",
            crust = "#0D0B14",
          },
        },
      })
      vim.cmd.colorscheme("catppuccin-mocha")
    end,
  },
}
