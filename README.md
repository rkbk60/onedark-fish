# onedark-fish
Apply onedark colorscheme to your fish shell terminal with `set_onedark` command.  
It is similar to [fish-vimcolor](https://github.com/ryotako/fish-vimcolor), but `set_onedark` also overwrites the terminal's color palette, text color, or background color (This process is based on [base16-shell](https://github.com/chriskempson/base16-shell)).

## Install
```
fisher add rkbk60/onedark-fish
```

## Usage
Add following lines to `~/.config/fish/config.fish`:
```fish
if status is-interactive
    set -l onedark_options '-b'

    if set -q VIM
        # Using from vim/neovim.
        set onedark_options "-256"
    else if string match -iq "eterm*" $TERM
        # Using from emacs.
        function fish_title; true; end
        set onedark_options "-256"
    end

    set_onedark $onedark_options
end
```

## Customize
You can overwrite color definition with `set_onedark_color`:
```fish
# change 'brblue' color.
set_onedark_color brblue 529CFA 69

# make 256 color closer to default 24bit color.
set_onedark_color bryellow default 222
set_onedark_color brcyan default 80

# you must execute 'set_onedark' to apply change.
set_onedark -b -256
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
        24bit RGB color code, like 'a3ff00', '0C060F'.
        It can use full size only, cannot use short style like '88D'.
        If you want not to change value, then set 'current',
        or you want to use preset value, then set 'default'.
    INDEX-256
        Index of 256 color, in the range from 16 to 255.
        If you want not to change value, then set 'current',
        or you want to use preset value, then set 'default'.

Examples:
    Define custom black color:
            $ set_onedark_color black 0a0400 231

    Overwrite only white 256 color index:
            $ set_onedark_color white current 255
```

## Preset
<table>
    <tr>
        <th>Color name</th>
        <th>Default</th>
        <th>256 color</th>
        <th>Using on commandline as (<code style="font-weight:bold;">$fish_color_</code>)</th>
    </tr>
    <tr>
        <td>black(0)</td>
        <td style="color:#282C34; font-weight:bold;">#282C34</td>
        <td style="color:#262626; font-weight:bold;">235 (#262626, Lv4)</td>
        <td>(terminal background)</td>
    </tr>
    <tr>
        <td>red(1)</td>
        <td style="background-color:#282C34; color:#BE5046;">#BE5046</td>
        <td style="background-color:#262626; color:#FF0000;">196 (#FF0000, r5:g0:b0)</td>
        <td></td>
    </tr>
    <tr>
        <td>green(2)</td>
        <td style="background-color:#282C34; color:#699959;">#699959</td>
        <td style="background-color:#262626; color:#5FAF5F;">71 (#5FAF5F, r1:g3:b1)</td>
        <td></td>
    </tr>
    <tr>
        <td>yellow(3)</td>
        <td style="background-color:#282C34; color:#D19A66;">#D19A66</td>
        <td style="background-color:#262626; color:#D7AF5F;">173 (#D7AF5F, r4:g3:b1)</td>
        <td></td>
    </tr>
    <tr>
        <td>blue(4)</td>
        <td style="background-color:#282C34; color:#2E6399;">#2E6399</td>
        <td style="background-color:#262626; color:#005FAF;">25 (#005FAF, r0:g1:b3)</td>
        <td>search-match(background)</td>
    </tr>
    <tr>
        <td>magenta(5)</td>
        <td style="background-color:#282C34; color:#9918A6;">#991BA6</td>
        <td style="background-color:#262626; color:#AF00AF;">90 (#AF00AF, r2:g0:b2)</td>
        <td></td>
    </tr>
    <tr>
        <td>cyan(6)</td>
        <td style="background-color:#282C34; color:#23878C;">#23878C</td>
        <td style="background-color:#262626; color:#008787;">30 (#005F5F, r0:g2:b2)</td>
        <td></td>
    </tr>
    <tr>
        <td>white(7)</td>
        <td style="background-color:#282C34; color:#ABB2BF;">#ABB2BF</td>
        <td style="background-color:#262626; color:#AFAFAF;">145 (#AFAFAF, r3:g3:b3)</td>
        <td>base foreground color</td>
    </tr>
    <tr>
        <td>brblack(8)</td>
        <td style="background-color:#282C34; color:#5C6370;">#5C6370</td>
        <td style="background-color:#262626; color:#5F5F5F;">59 (#5F5F5F, r1:g1:b1)</td>
        <td>comment, selection(background)</td>
    </tr>
    <tr>
        <td>brred(9)</td>
        <td style="background-color:#281C34; color:#E06C75;">#E06C75</td>
        <td style="background-color:#262626; color:#FF5F87;">204 (#FF5F87, r5:g1:b2)</td>
        <td>error, param, cwd</td>
    </tr>
    <tr>
        <td>brgreen(10)</td>
        <td style="background-color:#282C34; color:#98C379;">#98C379</td>
        <td style="background-color:#262626; color:#87D787;">114 (#87D787, r2:g4:b2)</td>
        <td>quote, pager-prefix, user</td>
    </tr>
    <tr>
        <td>bryellow(11)</td>
        <td style="background-color:#282C34; color:#E5C07B;">#E5C07B</td>
        <td style="background-color:#262626; color:#D7AF87;">180 (#D7AF87, r4:b3:g2)</td>
        <td></td>
    </tr>
    <tr>
        <td>brblue(12)</td>
        <td style="background-color:#282C34; color:#61AFEF;">#61AFEF</td>
        <td style="background-color:#262626; color:#00AFFF;">39 (#00AFFF, r0:g3:b5)</td>
        <td>host</td>
    </tr>
    <tr>
        <td>brmagenta(13)</td>
        <td style="background-color:#282C34; color:#C678DD;">#C678DD</td>
        <td style="background-color:#262626; color:#D75FD7;">170 (#D75FD7, r4:g1:b4)</td>
        <td>command, operator</td>
    </tr>
    <tr>
        <td>brcyan(14)</td>
        <td style="background-color:#282C34; color:#56B6C2;">#56B6C2</td>
        <td style="background-color:#262626; color:#00AFD7;">38 (#00AFD7, r0:g3:b4)</td>
        <td>redirection, match, escape, history-current</td>
    </tr>
    <tr>
        <td>brwhite(15)</td>
        <td style="background-color:#282C34; color:#CFD7E6;">#CFD7E6</td>
        <td style="background-color:#262626; color:#DADADA;">253 (#DADADA, Lv22)</td>
        <td></td>
    </tr>
</table>

**green/blue/magenta/cyan** are defined for this plugin. The other colors are matched one that defined on [original atom onedark](https://github.com/atom/one-dark-syntax) or [onedark.vim](https://github.com/joshdick/onedark.vim).

## TODO
- [x] add completions
- [x] add function to overwrite color definition
- [x] add option to `set_onedark` to use 256 color
- [ ] add option to overweite colors with each saturation level (for chromatic) or brightness level (for monochromatic)
- [x] make dark or bright green/blue/magenta/cyan
