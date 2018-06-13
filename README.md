# onedark-fish
Apply onedark colorscheme to your terminal with `set_onedark` command.  
It is similar to [fish-vimcolor](https://github.com/ryotako/fish-vimcolor), but `set_onedark` also overwrites the terminal's color palette, text color, or background color (This process is based on [base16-shell](https://github.com/chriskempson/base16-shell)).

## Install
```
fisher rkbk60/onedark-fish
```

## Usage
Add following lines to `~/.confing/fish/config.fish`:
```
if status is-interactive
    set -l onedark_options '-b'

    if set -q VIM
        # Using from (neo)vim.
        set onedark_options "-256"
    else if string match -iq "eterm*" $TERM
        # Using from emacs.
        function fish_title; end
        set onedark_options "-256"
    end

    set_onedark $onedark_options
end
```

## Customize
You can overwrite color definition with `set_onedark_color`:
```
# change 'bryellow' more brighter.
set_onedark_color bryellow FEC88B 207

# you must execute 'set_onedark' again to apply change.
set_onedark
```

## Commands
```
Name: set_onedark - Apply onedark colorscheme to your terminal.

Usage:
    set_onedark [options]

Options
    -256, --use-256-color   use 256 color
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
        or you want to use preset value, then set 'default'.
    INDEX-256
        Index of 256 color, in the range from 16 to 255.
        If you don't want to change value, then set 'current',
        or you want to use preset value, then set 'default'.

Examples:
    Define custom black color:
            $ set_onedark_color black 0a0400 231

    Overwrite only white 256 color index:
            $ set_onedark_color white current 255
```

## Preset color table
| color | HEX | 256 index |
---------------------------
| black(0)      | #282C34 | 235 (#262626, Lv4) |
| red(1)        | #BE5046 | 196 (#F00, R5:G0:B0) |
| green(2)      | #699959 | 70 (#390, R1:G3:B0) |
| yellow(3)     | #D19A66 | 173 (#C63, R4:G2:B1) |
| blue(4)       | #2E6399 | 104 (#66C, R2:G2:B4) |
| magenta(5)    | #733380 | 127 (#909, R3:G0:B3) |
| cyan(6)       | #23878C | 31 (#069, R0:G2:B3) |
| white(7)      | #ABB2BF | 145 (#AFAFAF, R3:G3:B3) |
| brblack(8)    | #5C6370 | 59 (#333, R1:G1:B1) |
| brred(9)      | #E06C75 | 204 (#F36, R5:G1:B2) |
| brgreen(10)   | #98C379 | 114 (#6C6, R2:G4:B2) |
| bryellow(11)  | #E5C07B | 180 (#C96, R4:G3:B2) |
| brblue(12)    | #61AFEF | 39 (#09F, R0:G3:B5) |
| brmagenta(13) | #C678DD | 170 (#C3C, R4:G1:B4) |
| brcyan(14)    | #56B6C2 | 38 (#09C, R0:G3:B4) |
| brwhite(15)   | #CFD7E6 | 253 (#DADADA, Lv22) |

## TODO
- [x] add completions
- [x] add function to overwrite color definition
- [x] add option to `set_onedark` to use 256 color
- [ ] add option to overweite colors as saturation(chromatic) level or brightness(monochromatic) level
- [x] make dark or bright green/blue/magenta/cyan
