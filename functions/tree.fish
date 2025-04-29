function tree --description "Print file tree"
    # Parse arguments
    argparse "a/all" "h/help" -- $argv

    # Check -h
    if set -q _flag_help
        echo "Usage: tree [arguments] [path]"
        echo "Arguments:"
        echo "  -a, --all    Show hidden files"
        echo "  -h, --help   Show help message"
        return 0
    end

    # Process target directory
    set -l target "."
    if test (count $argv) -gt 0
        set target $argv[1]
    end

    # Check if path exists
    if not test -e $target
        echo "No such file or directory: $target"
        return 1
    end

    # Define recursive function
    function _tree
        set -l dir $argv[1]
        set -l prefix $argv[2]
        set -l show_hidden $argv[3]

        set -l items
        if test "$show_hidden" = "true"
            set items $dir/{.*,*}
        else
            set items $dir/*
        end

        set items (string match -v "$dir/." $items)
        set items (string match -v "$dir/.." $items)

        if test (count $items) -eq 0
            return
        end

        set -l total (count $items)
        set -l current 0

        for item in $items
            set current (math $current + 1)
            set -l name (basename $item)

            if test $current -eq $total
                echo "$prefix└── $name"
                if test -d $item
                    _tree $item "$prefix    " $show_hidden
                end
            else
                echo "$prefix├── $name"
                if test -d $item
                    _tree $item "$prefix│   " $show_hidden
                end
            end
        end
    end

    # Display root directory name
    echo (basename (realpath $target))

    # Show hidden files based on arguments
    if set -q _flag_all
        _tree $target "" "true"
    else
        _tree $target "" "false"
    end
end