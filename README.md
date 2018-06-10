# onedark-fish
Apply onedark colorscheme to your terminal with `set_onedark` command.  
It is similar to [fish-vimcolor](https://github.com/ryotako/fish-vimcolor), but `set_onedark` also overwrites the terminal's color palette, text color, or background color (based on [base16-shell](https://github.com/chriskempson/base16-shell)).

## Install
```
fisher rkbk60/onedark-fish
```

## Command detail
```
Name: set_onedark - Apply onedark colorscheme to your terminal.

Usage:
    set_onedark [options]

Options
    -b, --set-background    set background color
    -h, --help              show this help message
```

## Usage
Add following lines to `~/.confing/fish/config.fish`:
```
if status --is-interactive
    set -l __onedark_options_on_startup '-b'
    set_onedark $__onedark_options_on_startup
end
```

## TODO
- [ ] add completions
- [ ] add function to overwrite color definition
- [ ] make dark or bright green/blue/magenta/cyan
