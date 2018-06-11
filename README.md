# onedark-fish
Apply onedark colorscheme to your terminal with `set_onedark` command.  
It is similar to [fish-vimcolor](https://github.com/ryotako/fish-vimcolor), but `set_onedark` also overwrites the terminal's color palette, text color, or background color (based on [base16-shell](https://github.com/chriskempson/base16-shell)).

## Install
```
fisher rkbk60/onedark-fish
```

## Usage
Add following lines to `~/.confing/fish/config.fish`:
```
if status --is-interactive
    set -l __onedark_options_on_startup '-b'
    set_onedark $__onedark_options_on_startup
end
```

## Commands
```
Name: set_onedark - Apply onedark colorscheme to your terminal.

Usage:
    set_onedark [options]

Options
    -b, --set-background    set background color
    -h, --help              show this help message
```

```
Name: set_onedark_color - Define color for onedark

Usage:
    set_onedark_color COLOR RGB-HEX INDEX-256
    set_onedark_color [-h|--help]

Arguments:
    COLOR
        Target color name that can use builtin 'set_color'.
        (Ex: black green brmagenta brwhite ...)
    RGB-HEX
        RGB color code, like 'a3ff00', '0C060F'.
        It can use full size only, cannot use short style like '88D'.
        If you don't want to change value, then set 'current',
        or don't want to use preset value, then set 'default'.
    INDEX-256
        Index of 256 color(0 ~ 255).
        If you don't want to change value, then set 'current',
        or don't want to use preset value, then set 'default'.

Examples:
    Define custom black color:
           \$ set_onedark_color black 0a0400 234

    Overwrite only white 256 color index:
           \$ set_onedark_color white current 255
```

## TODO
- [x] add completions
- [x] add function to overwrite color definition
- [ ] add option to `set_onedark` to use 256 color
- [ ] make dark or bright green/blue/magenta/cyan
