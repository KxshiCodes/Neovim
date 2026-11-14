# Neovim Configurations

My personal Neovim notes and configuration.

This repository start with basic commands and reminder to help me along the way. 
As I learn and customise Neovim, I'll keep addig my own settings, shortcuts, and configurations.

Feel free to explore, use, or take inpsiration from anyhting here. if it helps you, great!

## Font

I chose the [JetBrainsMono Nerd Font](https://www.nerdfonts.com/font-downloads) as it was the cleanest font and its nice to look at.

**Mac users:** A small heads-up! If you're on macOS, simply downloading the font isn't enough. I initially placed it in `~/.local/share/fonts/`, but macOS Terminal wouldn't recognise it.

To get it working properly, I had to copy the font files into the macOS user fonts directory:

```bash
~/Library/Fonts/
```
After that, I restarted Terminal and selected JetBrainsMono Nerd Font under Terminal → Settings → Profiles → Text → Font.

This also fixed the missing icons and question mark boxes in my Neovim dashboard. Just something to keep in mind if you're setting this up on a Mac!

## Norminette for 42 school

We use norminette to verify the code complies with the norm. 
This configuration runs [norminette](https://github.com/42School/norminette) automatically using [nvim-lint](https://github.com/mfussenegger/nvim-lint) and formats C files with [c_formatter_42](https://github.com/dawnbeen/c_formatter_42) using [conform.nvim](https://github.com/stevearc/conform.nvim). Both [norminette](https://github.com/42School/norminette) and [c_formatter_42](https://github.com/dawnbeen/c_formatter_42) are configured in a [custom mason registry](https://github.com/mason-org/mason.nvim#registries).

**Work in progress.**
