-- https://docs.astral.sh/ruff/editors/settings/

return {
  init_options = {
    settings = {
      lineLength = 79,
      lint = {
        preview = true,
        extendSelect = {
          "A",
          "ANN",
          "B",
          "E",
          "F",
          "Q",
        },
        ignore = {},
      },
      format = {
        preview = true,
      },
    },
  },
}
