#!/usr/bin/fish

function set_onedark -d "apply onedark colorscheme to your terminal"
    function __set_onedark_help
        echo "Name: set_onedark - Apply onedark colorscheme to your terminal."
        echo
        echo "Usage:"
        echo "    set_onedark [options]"
        echo
        echo "Options"
        echo "    -b, --set-background    set background color"
        echo "    -h, --help              show this help message"
    end

    set -l __onedark_set_background 'false'
    while count $argv > /dev/null
        switch $argv[1]
            case -h --help
                __set_onedark_help
                return
            case -b --set-background
                set __onedark_set_background 'true'
            case '-*'
                echo "set_onedark: unknown option '$argv[1]'" > /dev/stderr
                return 1
        end
        set -e argv[1]
    end

    # color definition: __onedark_xxx = [rgb, 256color, 16color]
    set -q __onedark_black;     or set -g __onedark_black      282c34  235  0
    set -q __onedark_red;       or set -g __onedark_red        be5046  196  1
    set -q __onedark_green;     or set -g __onedark_green      98c379  114  2
    set -q __onedark_yellow;    or set -g __onedark_yellow     d19a66  173  3
    set -q __onedark_blue;      or set -g __onedark_blue       61afef  39   4
    set -q __onedark_magenta;   or set -g __onedark_magenta    c678dd  170  5
    set -q __onedark_cyan;      or set -g __onedark_cyan       56b6c2  38   6
    set -q __onedark_white;     or set -g __onedark_white      abb2bf  145  7
    set -q __onedark_brblack;   or set -g __onedark_brblack    5c6370  59   8
    set -q __onedark_brred;     or set -g __onedark_brred      e06c75  204  9
    set -q __onedark_brgreen;   or set -g __onedark_brgreen    98c379  114  10
    set -q __onedark_bryellow;  or set -g __onedark_bryellow   e5c07b  180  11
    set -q __onedark_brblue;    or set -g __onedark_brblue     61afef  39   12
    set -q __onedark_brmagenta; or set -g __onedark_brmagenta  c678dd  170  13
    set -q __onedark_brcyan;    or set -g __onedark_brcyan     56b6c2  38   14
    set -q __onedark_brwhite;   or set -g __onedark_brwhite    cfd7e6  253  15

    function __onedark_code_of
        printf '%s/%s/%s' \
            (string join '' (string split '' $argv[1])[1 2]) \
            (string join '' (string split '' $argv[1])[3 4]) \
            (string join '' (string split '' $argv[1])[5 6])
    end

    function __onedark_input_options
        switch $argv[1]
            case 'fish_color_search_match'
                echo -n '--underline'
            case 'fish_color_valid_path'
                echo -n '--underline'
        end
    end

    if test -n "$TMUX"
        function __onedark_input_color -a target hex i256 i16
            set -g $target (printf '#%s' $hex) (__onedark_input_options $target)
        end
        function __onedark_output_color -a hex i256 i16
            printf '\033Ptmux;\033\033]4%d;rgb:%s\033\033\\\033%s' $i16 (__onedark_code_of $hex) \\
        end
        function __onedark_output_color_var -a target hex i256 i16
            printf '\033Ptmux;\033\033]%d;rgb:%s\033\033\\\033%s' $target (__onedark_code_of $hex) \\
        end
        function __onedark_output_color_custom -a target value
            printf '\033Ptmux;\033\033]%s%s\033\033\\\033%s' $target $value \\
        end

    else if string match -qr 'screen[-.]*' $TERM
        function __onedark_input_color -a target hex i256 i16
            set -g $target (printf '#%s' $hex) (__onedark_input_options $target)
        end
        function __onedark_output_color -a hex i256 i16
            printf '033P\033]4;%d;rgb:%s\007\033%s' $color[3] (__onedark_code_of $hex) \\
        end
        function __onedark_output_color_var -a target hex i256 i16
            printf '033P\033];%d;rgb:%s\007\033%s' $target (__onedark_code_of $hex) \\
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

    else
        function __onedark_input_color -a target hex i256 i16
            set -g $target (printf '#%s' $hex) (__onedark_input_options $target)
        end
        function __onedark_output_color -a hex i256 i16
            printf '\033]4;%d;rgb:%s\033%s' $i16 (__onedark_code_of $hex) \\
        end
        function __onedark_output_color_var -a target hex i256 i16
            printf '\033]%d;rgb:%s\033%s' $target (__onedark_code_of $hex) \\
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
        __onedark_output_color_custom Pg (__onedark_code_of $__onedark_brwhite[1]) # foreground
        __onedark_output_color_custom Ph (__onedark_code_of $__onedark_black[1])   # background
        __onedark_output_color_custom Pi (__onedark_code_of $__onedark_brwhite[1]) # bold text
        __onedark_output_color_custom Pj (__onedark_code_of $__onedark_brcyan[1])  # selection
        __onedark_output_color_custom Pk (__onedark_code_of $__onedark_black[1])   # selection text
        __onedark_output_color_custom Pl (__onedark_code_of $__onedark_brcyan[1])  # cursor
        __onedark_output_color_custom Pm (__onedark_code_of $__onedark_black[1])   # cursor text
    else if test -z "$VIM"
        __onedark_output_color_var 10 $__onedark_brwhite # foreground
        if test $__onedark_set_background = 'true'
            __onedark_output_color_var 11 $__onedark_black # background
            string match -qr "rxvt-*" $TERM
                and __onedark_output_color_var 708 $__onedark_black # internal border
        end
        __onedark_output_color_custom 12 ";7" # cursor (reverse video)
    end
end
