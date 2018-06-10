#!/usr/bin/fish

function set_onedark -a scheme -d "apply onedark colorscheme to your terminal"
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
        function __onedark_input_color
            set -g $argv[1] (printf '#%s' $argv[2]) (__onedark_input_options $argv[1])
        end
        function __onedark_output_color
            printf '\033Ptmux;\033\033]4%d;rgb:%s\033\033\\\033%s' $argv[3] (__onedark_code_of $argv[1]) \\
        end
        function __onedark_output_color_var
            printf '\033Ptmux;\033\033]%d;rgb:%s\033\033\\\033%s' $argv[1] (__onedark_code_of $argv[2]) \\
        end
        function __onedark_output_color_custom
            printf '\033Ptmux;\033\033]%s%s\033\033\\\033%s' $argv[1] (__onedark_code_of $argv[2]) \\
        end

    else if string match -qr 'screen[-.]*' $TERM
        function __onedark_input_color
            set -g $argv[1] (printf '#%s' $argv[2]) (__onedark_input_options $argv[1])
        end
        function __onedark_output_color
            printf '033P\033]4;%d;rgb:%s\007\033%s' $argv[3] (__onedark_code_of $argv[1]) \\
        end
        function __onedark_output_color_var
            printf '033P\033];%d;rgb:%s\007\033%s' $argv[1] (__onedark_code_of $argv[2]) \\
        end
        function __onedark_output_color_custom
            printf '033P\033];%s%s\007\033%s' $argv[1] (__onedark_code_of $argv[2]) \\
        end

    # TODO: use 256 color.
    else if string match -qr 'linux-*' $TERM
        function __onedark_input_color
            switch $argv[4]
                case 0;  set -g $argv[1] black     (__onedark_input_options $argv[1])
                case 1;  set -g $argv[1] red       (__onedark_input_options $argv[1])
                case 2;  set -g $argv[1] green     (__onedark_input_options $argv[1])
                case 3;  set -g $argv[1] yellow    (__onedark_input_options $argv[1])
                case 4;  set -g $argv[1] blue      (__onedark_input_options $argv[1])
                case 5;  set -g $argv[1] magenta   (__onedark_input_options $argv[1])
                case 6;  set -g $argv[1] cyan      (__onedark_input_options $argv[1])
                case 7;  set -g $argv[1] white     (__onedark_input_options $argv[1])
                case 8;  set -g $argv[1] brblack   (__onedark_input_options $argv[1])
                case 9;  set -g $argv[1] brred     (__onedark_input_options $argv[1])
                case 10; set -g $argv[1] brgreen   (__onedark_input_options $argv[1])
                case 11; set -g $argv[1] bryellow  (__onedark_input_options $argv[1])
                case 12; set -g $argv[1] brblue    (__onedark_input_options $argv[1])
                case 13; set -g $argv[1] brmagenta (__onedark_input_options $argv[1])
                case 14; set -g $argv[1] brcyan    (__onedark_input_options $argv[1])
                case 15; set -g $argv[1] brwhite   (__onedark_input_options $argv[1])
            end
        end
        function __onedark_output_color
            test $argv[3] -lt 16; and printf '\e]P%x%s' $argv[3] $argv[1]
        end
        function __onedark_output_color_var
            true
        end
        function __onedark_output_color_custom
            true
        end

    else
        function __onedark_input_color
            set -g $argv[1] (printf '#%s' $argv[2]) (__onedark_input_options $argv[1])
        end
        function __onedark_output_color
            printf '\033]4;%d;rgb:%s\033%s' $argv[3] (__onedark_code_of $argv[1]) \\
        end
        function __onedark_output_color_var
            printf '\033]%d;rgb:%s\033%s' $argv[1] (__onedark_code_of $argv[2]) \\
        end
        function __onedark_output_color_custom
            printf '\033]%s%s\033%s' $argv[1] (__onedark_code_of $argv[2]) \\
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
        __onedark_output_color_custom Pg $__onedark_brwhite # foreground
        __onedark_output_color_custom Ph $__onedark_black # background
        __onedark_output_color_custom Pi $__onedark_brwhite # bold text
        __onedark_output_color_custom Pj $__onedark_brcyan # selection
        __onedark_output_color_custom Pk $__onedark_black # selection text
        __onedark_output_color_custom Pl $__onedark_brcyan # cursor
        __onedark_output_color_custom Pm $__onedark_black # cursor text
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
