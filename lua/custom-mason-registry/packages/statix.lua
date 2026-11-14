return {
  name = "statix",
  description = "Lints and suggestions for the Nix programming language.",
  homepage = "https://github.com/oppiliappan/statix",
  licenses = {
    "MIT",
  },
  languages = {
    "Nix",
  },
  categories = {
    "Linter",
  },
  source = {
    id = "pkg:cargo/statix@v0.5.8?repository_url=https://github.com/oppiliappan/statix",
  },
  bin = {
    statix = "cargo:statix",
  },
}
