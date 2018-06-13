#!/usr/bin/fish

function set_onedark -d "apply onedark colorscheme to your terminal"
    function __set_onedark_help
        echo "Name: set_onedark - Apply onedark colorscheme to your terminal."
        echo
        echo "Usage:"
        echo "    set_onedark [options]"
        echo
        echo "Options"
        echo "    -256, --use-256-color   use 256 color"
        echo "    -b, --set-background    set background color"
        echo "    -h, --help              show this help message"
    end

    set -l set_background 'false'
    set -l use_256 'false'
    while count $argv > /dev/null
        switch $argv[1]
            case -h --help
                __set_onedark_help
                return
            case -b --set-background
                set __onedark_set_background 'true'
            case '-256' --use-256-color
                set use_256 'true'
            case '-*'
                echo "set_onedark: unknown option '$argv[1]'" > /dev/stderr
                return 1
        end
        set -e argv[1]
    end
    set -g __onedark_256_flag "$use_256"

    set -q __onedark_black;     or set_onedark_color black     default default
    set -q __onedark_red;       or set_onedark_color red       default default
    set -q __onedark_green;     or set_onedark_color green     default default
    set -q __onedark_yellow;    or set_onedark_color yellow    default default
    set -q __onedark_blue;      or set_onedark_color blue      default default
    set -q __onedark_magenta;   or set_onedark_color magenta   default default
    set -q __onedark_cyan;      or set_onedark_color cyan      default default
    set -q __onedark_white;     or set_onedark_color white     default default
    set -q __onedark_brblack;   or set_onedark_color brblack   default default
    set -q __onedark_brred;     or set_onedark_color brred     default default
    set -q __onedark_brgreen;   or set_onedark_color brgreen   default default
    set -q __onedark_bryellow;  or set_onedark_color bryellow  default default
    set -q __onedark_brblue;    or set_onedark_color brblue    default default
    set -q __onedark_brmagenta; or set_onedark_color brmagenta default default
    set -q __onedark_brcyan;    or set_onedark_color brcyan    default default
    set -q __onedark_brwhite;   or set_onedark_color brwhite   default default

    function __onedark_code_of -V use_256 -a hex i256
        test "$use_256" = 'true'
            and set -l color (__onedark_256_to_hex $i256)
            or  set -l color "$hex"
        printf '%s/%s/%s' \
            (string sub -s 1 -l 2 $color) \
            (string sub -s 3 -l 2 $color) \
            (string sub -s 5 -l 2 $color)
    end

    function __onedark_input_options
        switch $argv[1]
            case 'fish_color_search_match'
                echo -n '--underline'
            case 'fish_color_valid_path'
                echo -n '--underline'
        end
    end

    function __onedark_256_to_hex -a i256
        if test "$i256" -le 16
            # <16: system color palette, 16: black
            printf '000000'
            return
        else if test $i256 -gt 231
            # grayscale
            printf '%x' (math "8 + 10 * ($i256 - 231)")
            return
        end
        # detect color level (0 ~ 5)
        set i256 (math "$i256 - 16")
        set -l red (math "$i256 / 36")
        test $red -gt 5; and set red 5
        set -l green (math "($i256 - 36 * $red) / 6")
        test $green -gt 5; and set green 5
        set -l blue (math "$i256 - 36 * $red - 6 * $green")

        # convert to decimal color code
        set red   (math "51 * $red")
        set green (math "51 * $green")
        set blue  (math "51 * $blue")

        printf "%02x%02x%02x" $red $green $blue
    end

    if test -n "$TMUX"
        function __onedark_input_color -V use_256 -a target hex i256 i16
            set -l color
            test "$use_256" = 'true'
                and set color (__onedark_256_to_hex $i256)
                or  set color "$hex"
            set -g $target (printf '#%s' $color) (__onedark_input_options $target)
        end
        function __onedark_output_color -V use_256 -a hex i256 i16
            printf '\033Ptmux;\033\033]4%d;rgb:%s\033\033\\\033%s' $i16 (__onedark_code_of $hex $i256) \\
        end
        function __onedark_output_color_var -V use_256 -a target hex i256 i16
            printf '\033Ptmux;\033\033]%d;rgb:%s\033\033\\\033%s' $target (__onedark_code_of $hex $i256) \\
        end
        function __onedark_output_color_custom -a target value
            printf '\033Ptmux;\033\033]%s%s\033\033\\\033%s' $target $value \\
        end

    else if string match -qr 'screen[-.]*' $TERM
        function __onedark_input_color -V use_256 -a target hex i256 i16
            set -l color
            test "$use_256" = 'true'
                and set color (__onedark_256_to_hex $i256)
                or  set color "$hex"
            set -g $target (printf '#%s' $color) (__onedark_input_options $target)
        end
        function __onedark_output_color -V use_256 -a hex i256 i16
            printf '033P\033]4;%d;rgb:%s\007\033%s' $i16 (__onedark_code_of $hex $i256) \\
        end
        function __onedark_output_color_var -V use_256 -a target hex i256 i16
            printf '033P\033];%d;rgb:%s\007\033%s' $target (__onedark_code_of $hex $i256) \\
        end
        function __onedark_output_color_custom -a target value
            printf '033P\033];%s%s\007\033%s' $target $value \\
        end

    else if string match -qr 'linux-*' $TERM
        function __onedark_input_color -a target hex i256 i16
            switch $i16
                case 0;  set -g $target black     (__onedark_input_options $target)
                case 1;  set -g $target red       (__onedark_input_options $target)
                case 2;  set -g $target green     (__onedark_input_options $target)
                case 3;  set -g $target yellow    (__onedark_input_options $target)
                case 4;  set -g $target blue      (__onedark_input_options $target)
                case 5;  set -g $target magenta   (__onedark_input_options $target)
                case 6;  set -g $target cyan      (__onedark_input_options $target)
                case 7;  set -g $target white     (__onedark_input_options $target)
                case 8;  set -g $target brblack   (__onedark_input_options $target)
                case 9;  set -g $target brred     (__onedark_input_options $target)
                case 10; set -g $target brgreen   (__onedark_input_options $target)
                case 11; set -g $target bryellow  (__onedark_input_options $target)
                case 12; set -g $target brblue    (__onedark_input_options $target)
                case 13; set -g $target brmagenta (__onedark_input_options $target)
                case 14; set -g $target brcyan    (__onedark_input_options $target)
                case 15; set -g $target brwhite   (__onedark_input_options $target)
            end
        end
        function __onedark_output_color -a hex i256 i16
            test $i16 -lt 16; and printf '\e]P%x%s' $i16 $hex
        end
        function __onedark_output_color_var
            true
        end
        function __onedark_output_color_custom
            true
        end

    else if string match -qr 'eterm-*' $TERM
        function __onedark_input_color -a target hex i256 i16
            switch $i16
                case 0;  set -g $target black     (__onedark_input_options $target)
                case 1;  set -g $target red       (__onedark_input_options $target)
                case 2;  set -g $target green     (__onedark_input_options $target)
                case 3;  set -g $target yellow    (__onedark_input_options $target)
                case 4;  set -g $target blue      (__onedark_input_options $target)
                case 5;  set -g $target magenta   (__onedark_input_options $target)
                case 6;  set -g $target cyan      (__onedark_input_options $target)
                case 7;  set -g $target white     (__onedark_input_options $target)
                case 8;  set -g $target brblack   (__onedark_input_options $target)
                case 9;  set -g $target brred     (__onedark_input_options $target)
                case 10; set -g $target brgreen   (__onedark_input_options $target)
                case 11; set -g $target bryellow  (__onedark_input_options $target)
                case 12; set -g $target brblue    (__onedark_input_options $target)
                case 13; set -g $target brmagenta (__onedark_input_options $target)
                case 14; set -g $target brcyan    (__onedark_input_options $target)
                case 15; set -g $target brwhite   (__onedark_input_options $target)
            end
        end
        function __onedark_output_color
            true
        end
        function __onedark_output_color_var
            true
        end
        function __onedark_output_color_custom
            true
        end

    else
        function __onedark_input_color -V use_256 -a target hex i256 i16
            set -l color
            test "$use_256" = 'true'
                and set color (__onedark_256_to_hex $i256)
                or  set color "$hex"
            set -g $target (printf '#%s' $color) (__onedark_input_options $target)
        end
        function __onedark_output_color -V use_256 -a hex i256 i16
            printf '\033]4;%d;rgb:%s\033%s' $i16 (__onedark_code_of $hex $i256) \\
        end
        function __onedark_output_color_var -V use_256 -a target hex i256 i16
            printf '\033]%d;rgb:%s\033%s' $target (__onedark_code_of $hex $i256) \\
        end
        function __onedark_output_color_custom -a target value
            printf '\033]%s%s\033%s' $target $value \\
        end
    end

    __onedark_input_color fish_color_normal            $__onedark_white
    __onedark_input_color fish_color_command           $__onedark_brmagenta
    __onedark_input_color fish_color_quote             $__onedark_brgreen
    __onedark_input_color fish_color_redirection       $__onedark_brcyan
    __onedark_input_color fish_color_end               $__onedark_white
    __onedark_input_color fish_color_error             $__onedark_brred
    __onedark_input_color fish_color_param             $__onedark_brred
    __onedark_input_color fish_color_comment           $__onedark_brblack
    __onedark_input_color fish_color_match             $__onedark_brcyan
    __onedark_input_color fish_color_search_match      $__onedark_brcyan
    __onedark_input_color fish_color_operator          $__onedark_brmagenta
    __onedark_input_color fish_color_escape            $__onedark_white
    __onedark_input_color fish_color_autosuggestion    $__onedark_white
    __onedark_input_color fish_color_valid_path        $__onedark_white
    __onedark_input_color fish_color_history_current   $__onedark_brcyan
    __onedark_input_color fish_color_selection         $__onedark_brblack
    __onedark_input_color fish_pager_color_completion  $__onedark_white
    __onedark_input_color fish_pager_color_prefix      $__onedark_brgreen
    __onedark_input_color fish_pager_color_description $__onedark_white
    __onedark_input_color fish_pager_color_progress    $__onedark_white

    __onedark_output_color $__onedark_black
    __onedark_output_color $__onedark_red
    __onedark_output_color $__onedark_green
    __onedark_output_color $__onedark_yellow
    __onedark_output_color $__onedark_blue
    __onedark_output_color $__onedark_magenta
    __onedark_output_color $__onedark_cyan
    __onedark_output_color $__onedark_white
    __onedark_output_color $__onedark_brblack
    __onedark_output_color $__onedark_brred
    __onedark_output_color $__onedark_brgreen
    __onedark_output_color $__onedark_bryellow
    __onedark_output_color $__onedark_brblue
    __onedark_output_color $__onedark_brmagenta
    __onedark_output_color $__onedark_brcyan
    __onedark_output_color $__onedark_brwhite

    if test -n "$ITERM_SESSION_ID"
        function __onedark_iterm_color -V use_256
            test "$use_256" = 'true'
                and printf (__onedark_256_to_hex $argv[2])
                or  printf "$argv[1]"
        end
        __onedark_output_color_custom Pg (__onedark_iterm_color $__onedark_brwhite) # foreground
        __onedark_output_color_custom Ph (__onedark_iterm_color $__onedark_black)   # background
        __onedark_output_color_custom Pi (__onedark_iterm_color $__onedark_brwhite) # bold text
        __onedark_output_color_custom Pj (__onedark_iterm_color $__onedark_brcyan)  # selection
        __onedark_output_color_custom Pk (__onedark_iterm_color $__onedark_black)   # selection text
        __onedark_output_color_custom Pl (__onedark_iterm_color $__onedark_brcyan)  # cursor
        __onedark_output_color_custom Pm (__onedark_iterm_color $__onedark_black)   # cursor text
    else if test -z "$VIM"
        __onedark_output_color_var 10 $__onedark_brwhite # foreground
        if test "$__onedark_set_background" = 'true'
            __onedark_output_color_var 11 $__onedark_black # background
            string match -qr "rxvt-*" $TERM
                and __onedark_output_color_var 708 $__onedark_black # internal border
        end
        __onedark_output_color_custom 12 ";7" # cursor (reverse video)
    end
end
